//
//  PreloadingController.swift
//  Video & Go
//
//  Created by Developer on 02/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class PreloadingController: BaseAppSectionController {
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func buildView() {
        super.buildView()
        
        _animeLogo()
    }
    
    private func _animeLogo() {
        imgLogo.alpha = 0
        UIView.animate(withDuration: IS_DEBUG_MODE ? 0.5 : 3, delay: 0.2, animations: {
            self.imgLogo.alpha = 1.0
        }) { (finished) in
            self._onAnimeFinished()
        }
    }
    
    private func _onAnimeFinished() {
        buildLoading(bgColor: UIColor.clear)
        loadUrl(urlString: BASE_URL + CONFIG_PATH + "_" + VERSION_NUMBER + ".json")
    }
    
    override func addObservers() {
        let loadingFinishedObserver = NotificationCenter.default.addObserver(forName: .LOADING_FINISHED_NOTIFICATION, object: nil, queue: OperationQueue.main) { (notification) in
            
            UIView.animate(withDuration: IS_DEBUG_MODE ? 0.2 : 1.0, delay: IS_DEBUG_MODE ? 0.2 : 1.0, animations: {
                self.imgLogo.alpha = 0.0
            }) { (finished) in
                self._showMain(notif: notification)
            }
        }
        
        observers.append(loadingFinishedObserver)
        
        super.addObservers()
    }
    
    override func onLoadUrlFinished(data: Data) {
        print("V&G_FW___onLoadUrlFinished : ", data.toString())
        do {
            let configData = try JSONDecoder().decode(AppConfigJSONData.self, from: data)
            AppModel.sharedInstance.configData = configData
            
            super.onLoadUrlFinished(data: data)
            
        } catch let jsonErr {
            print(jsonErr.localizedDescription)
        }
    }
    
    private func _showMain(notif: Notification) -> Void {
        //let data: Data = notif.object as! Data
        //print("V&G_Project____showMain : ", self, data)
        self.performSegue(withIdentifier: "goToAppTabBar", sender: nil)
        //self.performSegue(withIdentifier: "segue", sender: nil)
    }
    
}
