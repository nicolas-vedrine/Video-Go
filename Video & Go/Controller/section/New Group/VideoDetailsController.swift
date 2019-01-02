//
//  VideoDetailsController.swift
//  Video & Go
//
//  Created by Developer on 31/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit
import WebKit

class VideoDetailsController: BaseSectionController, WKUIDelegate {

    var data: VideoPhotoTableViewCellData?
    private var _webView: WKWebView!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    
    
    override func setSectionName() {
        viewControllerData.name = VIDEO_DETAILS
        
        super.setSectionName()
    }
    
    override func buildView() {
        headerHeightConstraint = heightContraint
        
        super.buildView()
        
        _buildWebView()
        
        if(data != nil) {
            _loadRequest(urlString: (data?.urlMedia)!)
        }
    }
    
    private func _buildWebView() {
        let webConfiguration = WKWebViewConfiguration()
        _webView = WKWebView(frame: .zero, configuration: webConfiguration)
        _webView.uiDelegate = self
        containerView.addSubview(_webView)
        _webView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
    }
    
    private func _loadRequest(urlString: String) -> Void {
        let url: URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: url)
        _webView.load(request)
    }

}
