//
//  BanView.swift
//  Video & Go
//
//  Created by Developer on 30/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class BanView: VGBaseNibView {

    @IBOutlet weak var imgBan: UIImageViewAsync!
    @IBOutlet weak var lblTitleBan: UILabel!
    @IBOutlet weak var lblSubtitleBan: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lblTitleBan.text = ""
        lblSubtitleBan.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        lblTitleBan.text = ""
        lblSubtitleBan.text = ""
    }
    
    func setTitle(text: String) {
        lblTitleBan.text = text
    }
    
    func setSubtitle(text: String) {
        print("V&G_FW___setSubtitle : ", self, text)
        lblSubtitleBan.text = text
    }
    
    func setImage(urlString: String) {
        imgBan.downloadImage(urlString: urlString)
    }

}
