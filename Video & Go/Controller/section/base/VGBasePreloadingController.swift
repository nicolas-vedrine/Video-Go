//
//  VGBasePreloadingController.swift
//  Video & Go
//
//  Created by Developer on 01/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class VGBasePreloadingController: VGBaseViewController {
    
    public static let activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
    public static let bgColor = UIColor(white: 0, alpha: 0.7)
    
    private var _indicView: UIView?
    private var _loadingStyle: LoadingStyle = LoadingStyle.ACTIVITY_INDICATOR
    
    var indicView: UIView {
        return _indicView!
    }
    
    init(loadingStyle: LoadingStyle = LoadingStyle.ACTIVITY_INDICATOR, bgColor: UIColor = bgColor) {
        super.init(nibName: nil, bundle: nil)
        
        switch loadingStyle {
        case LoadingStyle.ACTIVITY_INDICATOR:
            _indicView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        case LoadingStyle.NONE:
            print("V&G_FW___init : ", self, LoadingStyle.NONE)
        default:
            _indicView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        }
        
        _loadingStyle = loadingStyle
        self.view.backgroundColor = bgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func buildView() {
        NotificationCenter.default.post(name: .CONFIG_LOAD_START_NOTIFICATION, object: self)
        
        super.buildView()
    }
    
    override func loadView() {
        print("V&G_FW___loadView : ", self)
        view = UIView()
        
        switch _loadingStyle {
        case LoadingStyle.ACTIVITY_INDICATOR:
            _indicView?.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(_indicView!)
            
            _indicView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            _indicView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        default:
            print("V&G_FW___loadView : ", self, "default")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // We use a 0.5 second delay to not show an activity indicator
        // in case our data loads very quickly.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?._startAnimate()
        }
    }
    
    private func _startAnimate() {
        switch _loadingStyle {
        case LoadingStyle.ACTIVITY_INDICATOR:
            let actIndicView: UIActivityIndicatorView = _indicView as! UIActivityIndicatorView
            actIndicView.startAnimating()
        default:
            print("V&G_FW____startAnimate : ", self)
        }
    }

}

enum LoadingStyle: Int {
    
    case NONE = 0
    case ACTIVITY_INDICATOR = 1
    
}
