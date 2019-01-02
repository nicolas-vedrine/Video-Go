//
//  BaseTableViewCell.swift
//  Video & Go
//
//  Created by Developer on 29/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class VGBaseTableViewCell: UITableViewCell {

    internal var viewCellData: VGBaseViewCellData?
    internal var baseLblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buildCell(tableViewCellData: VGBaseViewCellData) -> Void {
        self.viewCellData = tableViewCellData
        
        buildTitle()
    }
    
    internal func buildTitle() {
        print("V&G_Project___buildTitle : ", baseLblTitle)
        print("V&G_Project___buildTitle : ", self, viewCellData?.title)
        baseLblTitle.text = viewCellData?.title
    }

}

class VGBaseTableViewImageCell: VGBaseTableViewCell {
    
    internal weak var baseImgThumb: UIImageViewAsync!
    
    override func buildCell(tableViewCellData: VGBaseViewCellData) {
        super.buildCell(tableViewCellData: tableViewCellData)
        
        buildImage()
    }
    
    internal func buildImage() {
        let data = viewCellData as! VGBaseImageViewCellData
        baseImgThumb.downloadImage(urlString: data.imageUrl)
        baseImgThumb.onLoadComplete = { () -> () in
            self.onImageLoadComplete()
        }
    }
    
    internal func onImageLoadComplete() {
        print("V&G_FW___onImageLoadComplete : ", self)
    }
    
}

class VBBaseImageDescTableViewCell: VGBaseTableViewImageCell {
    
    internal var baseLblDesc: UILabel!
    
    override func buildCell(tableViewCellData: VGBaseViewCellData) {
        super.buildCell(tableViewCellData: tableViewCellData)
        
        buildDesc()
    }
    
    internal func buildDesc() {
        let data = viewCellData as! VideoPhotoTableViewCellData
        baseLblDesc.text = data.desc
    }
    
}
