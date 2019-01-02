//
//  HomeController.swift
//  Video & Go
//
//  Created by Developer on 23/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class HomeController: BaseSectionController, UITableViewDelegate, UITableViewDataSource, UIApplicationDelegate {
    
    @IBOutlet weak var vpView: HomeVideoPlayerView!
    @IBOutlet weak var tableView: UITableView!
    
    private var _datas: [HomeTableViewCellData] = [HomeTableViewCellData]()
    private let cellID: String = "homeCellID"
    
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    override func setSectionName() {
        viewControllerData.name = HOME
        super.setSectionName()
    }
    
    override func buildView() {
        view.layoutIfNeeded()
        _buildVideo()
        _buildTableView()
        
        super.buildView()
    }
    
    override func onApplicationDidEnterBackground(notification: Notification) {
        vpView.pause()
        
        super.onApplicationDidEnterBackground(notification: notification)
    }
    
    override func onApplicationWillEnterForeground(notification: Notification) {
        vpView.play()
        
        super.onApplicationWillEnterForeground(notification: notification)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vpView.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        vpView.stop()
    }
    
    private func _buildVideo() {
        let sectionData: HomeAppSectionJSONData = getAppSectionJSONData(name: viewControllerData.name!) as! HomeAppSectionJSONData
        let sectionContentData: HomeAppSectionContentJSONData = sectionData.content as! HomeAppSectionContentJSONData
        let urlString: String = BASE_URL + sectionContentData.video_url!
        vpView.configure(url: urlString)
        vpView.isLoop = true
    }
    
    @IBAction func videoAction(_ sender: Any) {
        let urlString: String = BASE_URL + "media/video/proto.mp4"
        vpView.setAsset(url: urlString)
    }
    
    
}

extension HomeController {
    
    private func _buildTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let sectionData: HomeAppSectionJSONData = getAppSectionJSONData(name: viewControllerData.name!) as! HomeAppSectionJSONData
        let sectionContentData: HomeAppSectionContentJSONData = sectionData.content as! HomeAppSectionContentJSONData
        var index: Int = 0
        for presentation: PresentationJSONData in sectionContentData.presentations! {
            let text: String = Loc.getMultilingualText(mlText: presentation.text!)
            let imageUrl: String = BASE_URL + presentation.image_url!
            let data: HomeTableViewCellData = HomeTableViewCellData(id: index, title: text, imageUrl: imageUrl)
            data.dec = presentation
            _datas.append(data)
            index += 1
        }
        DispatchQueue.main.async { [unowned self] in
            //self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data: HomeTableViewCellData = _datas[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? HomeTableViewCell {
            cell.buildCell(tableViewCellData: data)
            
            if indexPath.row == _datas.count - 1 {
                cell.isLastCell = true
            }
            return cell
        }
        return UITableViewCell()
    }
    
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }*/
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell: HomeTableViewCell = cell as! HomeTableViewCell
       // print("V&G_FW___willDisplay cell : ", cell.imgThumb.bounds.size)
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 60.0
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath)
        return UITableViewAutomaticDimension
    }*/
    
    /*func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
        } else {
            return 222
        }
    }*/
    
}
