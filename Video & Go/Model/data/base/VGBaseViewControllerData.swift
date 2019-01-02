//
//  VGBaseSectionData.swift
//  Video & Go
//
//  Created by Developer on 30/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

class VGBaseViewControllerData: VGBaseData {
    
    var name: String?
    var isScreenProtected: Bool!
    var isAlwaysOpened: Bool!
    
    init(id: Int = 0, isScreenProtected: Bool = false, isAlwaysOpened: Bool = false) {
        self.isScreenProtected = isScreenProtected
        self.isAlwaysOpened = isAlwaysOpened
        
        super.init(id: id)
    }
    
}
