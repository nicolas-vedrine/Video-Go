//
//  BaseLoadingController.swift
//  Video & Go
//
//  Created by Developer on 25/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class BaseLoadingController: UIViewController {

    /*@IBOutlet var bgView: UIView!
    
    override func buildPopup(_ parent: UIViewController, _ isModal: Bool, _ isClosable: Bool) {
        super.buildPopup(parent, isModal, isClosable)
    }
    
    override func buildView() {
        bgView.backgroundColor = UIColor.clear
        
        super.buildView()
    }
    
    override func addObservers() {
        super.addObservers()
        
        let openObserver: NSObjectProtocol = NotificationCenter.default.addObserver(forName: .LOADING_START_NOTIFICATION, object: nil, queue: OperationQueue.main) { (notification) in
            //self.open(self, self)
        }
        observers.append(openObserver)
        
        let closeObserver: NSObjectProtocol = NotificationCenter.default.addObserver(forName: .LOADING_FINISHED_NOTIFICATION, object: nil, queue: OperationQueue.main) { (notification) in
            self.close()
        }
        observers.append(closeObserver)
    }*/
    

}
