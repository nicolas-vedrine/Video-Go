//
//  TestControllerViewController.swift
//  Video & Go
//
//  Created by Developer on 09/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class TestController: BaseSectionController {

    
    @IBOutlet weak var vpView: HomeVideoPlayerView!
    
    override func buildView() {
        /*buildLoading(loadingStyle: LoadingStyle.ACTIVITY_INDICATOR, bgColor: UIColor.black)
        showLoading()*/
        
        vpView.configure(url: "http://192.168.0.40/videoandgo/www/media/video/bandeau-vimeo-ios.m4v")
        vpView.isLoop = true
        vpView.play()
        
        super.buildView()
    }

}
