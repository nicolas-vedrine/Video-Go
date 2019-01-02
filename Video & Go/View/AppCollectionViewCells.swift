//
//  AppCollectionViewCells.swift
//  Video & Go
//
//  Created by Developer on 10/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class AppCollectionViewCells: VGBaseImageCollectionViewCell {
    
    override func buildCell(viewCellData: VGBaseViewCellData) {
        super.buildCell(viewCellData: viewCellData)
    }
    
}

class PhotoCollectionViewCell: VBBaseImageDescCollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgThumb: UIImageViewAsync!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func buildCell(viewCellData: VGBaseViewCellData) {
        baseLblTitle = lblTitle
        baseImgThumb = imgThumb
        baseLblDesc = lblDesc
        
        baseLblDesc.isHidden = true
        
        super.buildCell(viewCellData: viewCellData)
        
        buildDate()
        
        /*stackView.layoutMargins = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        stackView.isLayoutMarginsRelativeArrangement = true*/
    }
    
    private func buildDate() {
        let data = viewCellData as! VideoPhotoTableViewCellData
        //TODO : change date function
        let configData = AppModel.sharedInstance.configData
        let time = configData?.language?.time
        let timeAgoObj: TimeAgoObject = data.date.timeAgoObj()
        lblDate.text = Loc.getTimeAgoString(timeAgoObj: timeAgoObj, time: time!)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
}


class PhotoDetailsCollectionViewCell: VGBaseImageCollectionViewCell {
    
    @IBOutlet weak var lblIndex: UILabel!
    @IBOutlet weak var imgThumb: UIImageViewAsync!
    
    override func buildCell(viewCellData: VGBaseViewCellData) {
        baseLblTitle = lblIndex
        baseImgThumb = imgThumb
        
        super.buildCell(viewCellData: viewCellData)
    }
    
    func setIndex(text: String) {
        baseLblTitle.text = text
    }
    
    override var isHighlighted: Bool {
        didSet {
            imgThumb.layer.borderColor = isSelected ? BLUE_COLOR.cgColor : UIColor.clear.cgColor
            imgThumb.layer.borderWidth = isSelected ? 2 : 0
            super.isHighlighted = isHighlighted
        }
    }
    
}
