//
//  BaseAppUITableViewCell.swift
//  Video & Go
//
//  Created by Developer on 29/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

/*class BaseAppTableViewCell: VGBaseTableViewImageCell {
    
    /*internal var baseLblTitle: UILabel!
    internal var baseImgThumb: UIImageViewAsync!*/
    
    //internal var baseAppViewCellData: BaseAppViewCellData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func buildCell(tableViewCellData: VGBaseViewCellData) {
        super.buildCell(tableViewCellData: tableViewCellData)
        
        //baseAppViewCellData = (tableViewCellData as? BaseAppViewCellData)!
        
        /*_buildDesc()
        _buildImage()*/
    }
    
    /*private func _buildImage() {
        baseImgThumb.downloadImage(urlString: BASE_URL + (baseAppViewCellData?.imageUrl)!)
    }
    
    private func _buildDesc() {
        baseLblTitle.text = baseAppViewCellData?.title
        //baseLblDesc.text = "toto"
        print("V&G_Project____buildDesc : ", self, baseAppViewCellData?.title)
    }*/

}*/

class HomeTableViewCell: VGBaseTableViewImageCell {
    
    @IBOutlet weak var imgThumb: UIImageViewAsync!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var spacerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblHeightConstraint: NSLayoutConstraint!
    
    private let _cellSpace: CGFloat = 15.0
    private let _lastCellSpace: CGFloat = 5.0
    private var _cellHeight: CGFloat = 263.5
    
    var isLastCell: Bool = false {
        didSet {
            if isLastCell {
                spacerViewHeightConstraint.constant = _lastCellSpace
            }
        }
    }
    
    override func buildCell(tableViewCellData: VGBaseViewCellData) {
        baseImgThumb = imgThumb
        baseLblTitle = lblTitle
        
        _cellHeight = self.frame.size.height
        
        super.buildCell(tableViewCellData: tableViewCellData)
        
        lblTitle.lineBreakMode = .byClipping
        lblTitle.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        spacerViewHeightConstraint.constant = _cellSpace
        self.frame.size.height = _cellHeight
    }
    
    override func onImageLoadComplete() {
        super.onImageLoadComplete()
        
        /*print("V&G_FW___onImageLoadComplete HomeTableViewCell : ", self)
        let image = baseImgThumb.image
        let ratio = (image?.size.width)! / (image?.size.height)!
        if contentView.frame.width > contentView.frame.height {
            let newHeight = contentView.frame.width / ratio
            baseImgThumb.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        } else{
            let newWidth = contentView.frame.height * ratio
            baseImgThumb.widthAnchor.constraint(equalToConstant: newWidth)
        }
        
        baseImgThumb.image = image*/
        
        /*baseLblTitle.translatesAutoresizingMaskIntoConstraints = false
        baseLblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        baseLblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        baseLblTitle.topAnchor.constraint(equalTo: baseImgThumb.bottomAnchor, constant: 20).isActive = true
        baseLblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true*/
        
        print("V&G_FW___onImageLoadCompleteeeee : baseImgThumb.image?.size", baseImgThumb.image?.size)
        print("V&G_FW___onImageLoadCompleteeeee : baseImgThumb.bounds.size", baseImgThumb.bounds.size)
        
        let ratio = (baseImgThumb.image?.size.width)! / baseImgThumb.bounds.size.width
        let imageHeight = (baseImgThumb.image?.size.height)! / ratio
        let dif = imageHeight - baseImgThumb.bounds.size.height
        self.frame.size.height += dif
        
        print("V&G_FW___onImageLoadCompleteeeee : dif", dif)
        print("V&G_FW___onImageLoadCompleteeeee : self.frame.size.height ", self.frame.size.height)
        
        //lblHeightConstraint.constant
        
        self.layoutIfNeeded()
    }
    
}

class VideoTableViewCell: VBBaseImageDescTableViewCell {
    
    
    @IBOutlet weak var imgThumb: UIImageViewAsync!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    
    
    //private let cellSpacing: CGFloat = 90.0
    
    override func buildCell(tableViewCellData: VGBaseViewCellData) {
        baseImgThumb = imgThumb
        baseLblTitle = lblTitle
        baseLblDesc = lblDesc
        
        super.buildCell(tableViewCellData: tableViewCellData)
        
        _buildDate()
        _buildHour()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //layoutMargins = UIEdgeInsetsMake(cellSpacing, 0, cellSpacing, 0)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3, animations: {
                self.containerView.backgroundColor = self.isHighlighted ? BLUE_COLOR : WHITE_COLOR
                self.imgArrow.tintColor = self.isHighlighted ? BLUE_COLOR : WHITE_COLOR
            }) { (finished) in
                
            }
            
            super.isHighlighted = isHighlighted
        }
    }
    
    /*override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isHighlighted ? BLUE_COLOR : WHITE_COLOR
            imgArrow.tintColor = isHighlighted ? BLUE_COLOR : WHITE_COLOR
            super.isSelected = isSelected
        }
    }*/
    
    private func _buildDate() {
        //TODO: change the date function
        let data = viewCellData as! VideoPhotoTableViewCellData
        lblDate.text = data.date.toFormat(format: DateFormatType.fr_FR_day)
    }
    
    private func _buildHour() {
        //TODO: change the date function
        let data = viewCellData as! VideoPhotoTableViewCellData
        lblHour.text = data.date.toFormat(format: DateFormatType.fr_FR_hour)
    }
    
}

