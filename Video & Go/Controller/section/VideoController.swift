//
//  VideoController.swift
//  Video & Go
//
//  Created by Developer on 27/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class VideoController: BaseBanAPISectionController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private let cellID: String = "videoCell"
    private let segueID: String = "goToVideoDetails"
    
    private let cellHeight: CGFloat = 83.0
    private let topMargin: CGFloat = 9.0
    
    override func setSectionName() {
        viewControllerData.name = VIDEO
        super.setSectionName()
    }
    
    override func parseData(data: Data) {
        super.parseData(data: data)
        
        _buildTableView()
    }
    
}

extension VideoController {
    
    private func _buildTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = cellHeight + topMargin
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data: VideoPhotoTableViewCellData = datas[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? VideoTableViewCell {
            cell.buildCell(tableViewCellData: data)
            print("V&G_Project___cellForRowAt : ", self, cell.isSelected)
            if cell.isSelected {
                cell.isHighlighted = true
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight + topMargin
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight + topMargin
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isHighlighted = true
            cell.isSelected = true
        }
        let data: VideoPhotoTableViewCellData = datas[indexPath.row]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.performSegue(withIdentifier: self.segueID, sender: data)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.isHighlighted = false
            cell.isSelected = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let vc = segue.destination as? VideoDetailsController {
                vc.data = sender as? VideoPhotoTableViewCellData
            }
        }
    }
    
}
