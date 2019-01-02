//
//  VGBaseCollectionViewCell.swift
//  Video & Go
//
//  Created by Developer on 10/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class VGBaseCollectionViewCell: UICollectionViewCell {
    
    internal var viewCellData: VGBaseViewCellData?
    internal var baseLblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }*/
    
    func buildCell(viewCellData: VGBaseViewCellData) -> Void {
        self.viewCellData = viewCellData
        
        buildTitle()
    }
    
    internal func buildTitle() {
        baseLblTitle.text = viewCellData?.title
    }
    
    override var isSelected: Bool {
        didSet {
            ///self.alpha = self.isSelected ? 0.5 : 1.0
            super.isSelected = isSelected
        }
    }
    
    /*override var isHighlighted: Bool {
        didSet {
            self.alpha = self.isSelected ? 0.5 : 1.0
            super.isHighlighted = isHighlighted
        }
    }*/
    
    /*override var isSelected: Bool {
        didSet {
            self.alpha = self.isSelected ? 0.5 : 1.0
            super.isSelected = isSelected
        }
    }*/
    
}

class VGBaseImageCollectionViewCell: VGBaseCollectionViewCell {
    
    internal var baseImgThumb: UIImageViewAsync!
    
    override func buildCell(viewCellData: VGBaseViewCellData) {
        super.buildCell(viewCellData: viewCellData)
        
        buildImage()
    }
    
    internal func buildImage() {
        let data: VGBaseImageViewCellData = viewCellData as! VGBaseImageViewCellData
        baseImgThumb.downloadImage(urlString: data.imageUrl)
    }
    
}

class VBBaseImageDescCollectionViewCell: VGBaseImageCollectionViewCell {
    
    internal var baseLblDesc: UILabel!
    
    override func buildCell(viewCellData: VGBaseViewCellData) {
        super.buildCell(viewCellData: viewCellData)
        
        buildDesc()
    }
    
    internal func buildDesc() {
        print("V&G_Project___buildDesc : ", type(of: viewCellData))
        let data: VGBaseImageDescViewCellData = viewCellData as! VGBaseImageDescViewCellData
        baseLblDesc.text = data.desc
    }
    
}
