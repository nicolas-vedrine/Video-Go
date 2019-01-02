//
//  PhotoController.swift
//  Video & Go
//
//  Created by Developer on 27/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class PhotoController: BaseBanAPISectionController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellID = "photoCellID"
    private let segueID = "goToPhotoDetails"
    
    private let minimumInteritemSpacing: CGFloat = 0
    private let minimumLineSpacing: CGFloat = 5
    private let sideMargins: CGFloat = 5
    private let nItemsPerLine: CGFloat = 2
    private let cellWidth: CGFloat = 180.0
    private let cellHeight: CGFloat = 238.0
    
    /*var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!*/
    
    override func setSectionName() {
        viewControllerData.name = PHOTO
        super.setSectionName()
    }
    
    override func parseData(data: Data) {
        super.parseData(data: data)
        
        _buildCollectionView()
    }

}

extension PhotoController {
    
    private func _buildCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        _buildLayout()
        
        DispatchQueue.main.async { [unowned self] in
            //self.collectionView?.reloadData()
        }
    }
    
    private func _buildLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        var width = ((collectionView.superview?.bounds.width)!) / nItemsPerLine
        width -= sideMargins * 2
        let ratio = cellWidth / width
        let height = cellHeight / ratio - 100
        layout.sectionInset = UIEdgeInsets(top: 0, left: sideMargins / 2, bottom: 0, right: sideMargins / 2)
        layout.estimatedItemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data: VideoPhotoTableViewCellData = datas[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoCollectionViewCell {
            cell.buildCell(viewCellData: data)
            return cell
        }
        return UICollectionViewCell()
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /*var width = ((collectionView.superview?.bounds.width)!)
        width -= sideMargins * 2
        let height = (width * 2) + 30*/
     
        let width = (collectionView.superview?.bounds.width)! - sideMargins * 2
        return CGSize(width: ((width / 2) ) , height: ((width / 2) + 30))
     
        //return CGSize(width: width / 2, height: height / 2)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data: VideoPhotoTableViewCellData = datas[indexPath.row]
        performSegue(withIdentifier: segueID, sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let vc = segue.destination as? PhotoDetailsController {
                let data: VideoPhotoTableViewCellData = sender as! VideoPhotoTableViewCellData
                vc.project = data.dec as? Project
            }
        }
    }
    
}
