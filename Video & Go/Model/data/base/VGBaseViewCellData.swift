//
//  BaseTableViewCellData.swift
//  Video & Go
//
//  Created by Developer on 29/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

class VGBaseViewCellData: VGBaseData {
    
    var title: String
    
    init(id: Int, title: String) {
        self.title = title
        
        super.init(id: id)
    }
    
}

class VGBaseImageViewCellData: VGBaseViewCellData {
    
    var imageUrl: String
    var imagePathType: ImagePathType
    
    init(id: Int, title: String, imageUrl: String, imagePathType: ImagePathType = ImagePathType.url) {
        self.imageUrl = imageUrl
        self.imagePathType = imagePathType
        
        super.init(id: id, title: title)
    }
    
}

enum ImagePathType: String {
    case url = "url"
    case path = "path"
}

class VGBaseImageDescViewCellData: VGBaseImageViewCellData {
    
    internal var desc: String
    
    init(id: Int, title: String, imageUrl: String, imagePathType: ImagePathType, desc: String) {
        self.desc = desc
        
        super.init(id: id, title: title, imageUrl: imageUrl, imagePathType: imagePathType)
    }
    
}
