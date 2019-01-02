//
//  BasePopupController.swift
//  Video & Go
//
//  Created by Developer on 25/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class BasePopupController: VGBaseViewController {
    
    var parentVC: UIViewController?
    var isModal: Bool?
    var isClosable: Bool?
    
    func buildPopup(_ parentVC: UIViewController, _ isModal:Bool = true, _ isClosable:Bool = false) -> Void {
        self.parentVC = parentVC
        self.isModal = isModal
        self.isClosable = isClosable
    }
    
}
