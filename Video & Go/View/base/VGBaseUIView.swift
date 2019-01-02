//
//  VGBaseUIView.swift
//  Video & Go
//
//  Created by Developer on 31/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class VGBaseUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buildView()
    }
    
    internal func buildView() -> Void {
        print("V&G_FW___buildView : ", self)
    }

}
