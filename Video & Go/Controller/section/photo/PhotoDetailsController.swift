//
//  PhotoDetailsController.swift
//  Video & Go
//
//  Created by Developer on 31/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class PhotoDetailsController: BaseBanAPISectionController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgBig: UIImageViewAsync!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    
    private let _cellID = "photoDetailsCellID"
    private var _selectedCell: PhotoDetailsCollectionViewCell!
    
    override func setSectionName() {
        viewControllerData.name = PHOTO_DETAILS
        super.setSectionName()
    }
    
    override func buildView() {
        headerHeightConstraint = heightContraint
        
        super.buildView()
    }
    
    override func parseData(data: Data) {
        super.parseData(data: data)
        
        print("V&G_Project___parseData : ", self, datas)
        _buildCollectionView()
    }
    
}

extension PhotoDetailsController {
    
    private func _buildCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DispatchQueue.main.async { [unowned self] in
            //self.collectionView.reloadData()
            //self._selectFirstCell()
            
            /*DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
             self._selectFirstCell()
             }*/
            
            /*self.collectionView.performBatchUpdates(nil, completion: {
             (result) in
             self._selectFirstCell()
             })*/
            
            DispatchQueue.main.async {
                self._selectFirstCell()
            }
        }
        
    }
    
    private func _selectFirstCell() {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        self._selectItem(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index: Int = indexPath.row
        let data: VideoPhotoTableViewCellData = datas[index]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _cellID, for: indexPath) as? PhotoDetailsCollectionViewCell {
            cell.buildCell(viewCellData: data)
            let total: Int = datas.count
            let totalString: String = String(total)
            let digits: Int = total < 10 ? totalString.count : totalString.count - 1
            let indexStringFormatted: String = (index + 1).toTimeFormatted(digits: digits)
            let totalStringFormatted = total.toTimeFormatted(digits: digits)
            cell.setIndex(text: indexStringFormatted + "/" + totalStringFormatted)
            if cell.isSelected {
                cell .isHighlighted = true
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _selectItem(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell: PhotoDetailsCollectionViewCell = collectionView.cellForItem(at: indexPath) as? PhotoDetailsCollectionViewCell {
            cell.isHighlighted = false
        }
    }
    
    private func _selectItem(indexPath : IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        let cell: PhotoDetailsCollectionViewCell = collectionView.cellForItem(at: indexPath) as! PhotoDetailsCollectionViewCell
        //print("V&G_Project___selectItem : ", self, cell.isSelected)
        cell.isHighlighted = true
        
        let data = datas[indexPath.row]
        imgBig.downloadImage(urlString: data.urlMedia)
    }
    
}
