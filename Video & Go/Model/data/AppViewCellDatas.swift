//
//  BaseAppTableViewCellData.swift
//  Video & Go
//
//  Created by Developer on 29/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

class HomeTableViewCellData: VGBaseImageViewCellData {
    
    override init(id: Int, title: String, imageUrl: String, imagePathType: ImagePathType = ImagePathType.url) {
        super.init(id: id, title: title, imageUrl: imageUrl)
    }
    
}

class VideoPhotoTableViewCellData: VGBaseImageDescViewCellData {
    
    var date: Date
    var urlMedia: String
    
    init(id: Int, title: String, imageUrl: String, imagePathType: ImagePathType = ImagePathType.url, desc: String, date: Date, urlMedia: String) {
        self.date = date
        self.urlMedia = urlMedia
        
        super.init(id: id, title: title, imageUrl: imageUrl, imagePathType: imagePathType, desc: desc)
    }
    
}

/*class VideoTableViewCellData: BaseAppTableViewCellData {
    
    override init(id: Int, descText: String, imageUrl: String, imagePathType: Int = 1) {
        super.init(id: id, descText: descText, imageUrl: imageUrl)
    }
    
}
*/
