//
//  BaseSectionController.swift
//  Video & Go
//
//  Created by Developer on 02/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit


class BaseAppSectionController: VGBaseAppSectionController {
    
    override func buildView() {
        buildBackground()
        
        super.buildView()
    }
    
    internal func buildBackground() -> Void {
        view.backgroundColor = BACKGROUND_COLOR
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}


class BaseSectionController: BaseAppSectionController {
    
    internal var headerView: HeaderView!
    internal var containerView: UIView!
    internal var headerHeightConstraint: NSLayoutConstraint!
    
    internal let heightConstraintGap: CGFloat = 14
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            //self.buildLoading()
        }
    }
    
    override func buildView() {
        buildHeader()
        buildContainer()
        showHeaderClose()
        
        super.buildView()
        
        view.layoutIfNeeded()
    }
    
    internal func showHeaderClose() {
        if viewControllerData.name == VIDEO_DETAILS || viewControllerData.name == PHOTO_DETAILS {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.headerView?.showClose()
                
                self.headerView?.btnClose.isHidden = false
                self.headerView?.btnClose.alpha = 0.0
                
                UIView.animate(withDuration: 0.50, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                    self.headerView?.btnCloseHeightConstraint.constant += self.heightConstraintGap
                    self.headerView?.layoutIfNeeded()
                    self.headerHeightConstraint.constant += self.heightConstraintGap
                    self.view.layoutIfNeeded()
                }) { (finished) in
                    //self._onAnimeProgress()
                }
                
                UIView.animate(withDuration: 0.75, animations: {
                    self.headerView?.btnClose.alpha = 1.0
                }) { (finished) in
                    //self._onAnimeFinished()
                }
                
            }
        }
    }
    
    internal func buildContainer() {
        containerView = view.viewWithTag(50)
        containerView.backgroundColor = UIColor.clear
        view.bringSubview(toFront: containerView)
    }
    
    internal func buildHeader() {
        let headerContainer = view.viewWithTag(0)
        headerContainer?.backgroundColor = UIColor.clear
        
        headerView = HeaderView()
        headerView?.backgroundColor = UIColor.clear
        headerContainer?.addSubview(headerView!)
        headerView.anchor(top: headerContainer?.topAnchor, leading: headerContainer?.leadingAnchor, bottom: headerContainer?.bottomAnchor, trailing: headerContainer?.trailingAnchor)
        
        if viewControllerData.name == VIDEO_DETAILS || viewControllerData.name == PHOTO_DETAILS {
            headerView?.onClose = { () -> () in
                self.onHeaderClose()
            }
        }
    }
    
    internal func onHeaderClose() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class BaseBanSectionController: BaseSectionController {
    
    internal var banView: BanView?
    
    override func buildView() {
        buildBan()
        
        super.buildView()
    }
    
    internal func buildBan() {
        banView = view.viewWithTag(100) as? BanView
        //print("V&G_FW___buildBan : ", self, banView)
    }
    
    internal func setBan() {
        print("V&G_Project___setBan : ", self)
        
        let sectionData: VGBaseAppSectionJSONData = getAppSectionJSONData(name: viewControllerData.name!)!
        let sectionContentData: BaseAppSectionBanContentJSONData = sectionData.content as! BaseAppSectionBanContentJSONData
        
        if let titles = sectionContentData.titles {
            setBanTitle(text: Loc.getMultilingualText(mlText: titles))
        }
        if let subtitles = sectionContentData.subtitles {
            setBanSubtitle(text: Loc.getMultilingualText(mlText: subtitles))
        }
        if let banImgUrl = sectionContentData.ban_img_url {
            setBanImage(urlString: BASE_URL + banImgUrl)
        }
    }
    
    internal func setBanTitle(text: String) {
        banView?.setTitle(text: text)
    }
    
    internal func setBanSubtitle(text: String) {
        //print("V&G_FW___setBanSubtitle : ", self, banView)
        banView?.setSubtitle(text: text)
    }
    
    internal func setBanImage(urlString: String) {
        banView?.setImage(urlString: urlString)
    }
    
}

class BaseBanAPISectionController: BaseBanSectionController {
    
    internal var datas: [VideoPhotoTableViewCellData] = [VideoPhotoTableViewCellData]()
    var project: Project?
    
    override func buildView() {
        super.buildView()
        
        _setRequest()
    }
    
    private func _setRequest() {
        var urlString: String?
        switch viewControllerData.name {
        case VIDEO:
            urlString = VIMEO_URL + VIMEO_CHANNELS_METHOD + "/" + VIDEO_AND_GO_CHANNEL_ID + "/" + VIMEO_VIDEOS_METHOD + "?access_token=" + VIMEO_ACCESS_TOKEN
        case PHOTO:
            urlString = BEHANCE_URL + BEHANCE_USERS_METHOD + "/" + ADOBE_USER_NAME + "/" + BEHANCE_PROJECTS_METHOD + "?api_key=" + BEHANCE_API_KEY
        case PHOTO_DETAILS:
            let id: Int = (project?.id)!
            let projectID = String(id)
            urlString = BEHANCE_URL + BEHANCE_PROJECTS_METHOD + "/" + projectID + "?api_key=" + BEHANCE_API_KEY
        default:
            print("V&G_Project___<#name#> : ", self)
        }
        print("V&G_Project____setRequest : ", self, urlString)
        buildLoading(loadingStyle: LoadingStyle.ACTIVITY_INDICATOR)
        loadUrl(urlString: urlString!)
    }
    
    override func onLoadUrlFinished(data: Data) {
        DispatchQueue.main.async { [unowned self] in
            //self.containerView.isHidden = false
            self.parseData(data: data)
            self.setBan()
        }
        
        super.onLoadUrlFinished(data: data)
    }
    
    override func setBan() {
        super.setBan()
        
        let sectionData: VGBaseAppSectionJSONData = getAppSectionJSONData(name: viewControllerData.name!)!
        let sectionContentData: BaseAppSectionBanContentJSONData = sectionData.content as! BaseAppSectionBanContentJSONData
        if viewControllerData.name == PHOTO_DETAILS {
            setBanTitle(text: (project?.name)!)
            
            let configData = AppModel.sharedInstance.configData
            let time = configData?.language?.time
            let timeAgoObj: TimeAgoObject = (project?.modified_on?.timeAgoObj())!
            setBanSubtitle(text: Loc.getTimeAgoString(timeAgoObj: timeAgoObj, time: time!))
        } else {
            setBanSubtitle(text: String(datas.count) + " " + (Loc.getMultilingualText(mlText: sectionContentData.subtitles!)))
        }
    }
    
    internal func parseData(data: Data) {
        var localDatas: [Decodable]?
        do {
            switch viewControllerData.name {
            case VIDEO:
                let vimeoData = try JSONDecoder().decode(VimeoData.self, from: data)
                localDatas = vimeoData.data!
            case PHOTO:
                let behanceProjects = try JSONDecoder().decode(BehanceProjects.self, from: data)
                localDatas = behanceProjects.projects
            case PHOTO_DETAILS:
                let behanceProject = try JSONDecoder().decode(BehanceProject.self, from: data)
                localDatas = behanceProject.project.modules
            default:
                print("V&G_Project___<#name#> : ", self, "parseData")
            }
            for dataDec in localDatas! {
                var cellData: VideoPhotoTableViewCellData?
                var id: Int = 0
                var title: String?
                var desc: String?
                var imageUrl: String?
                var date: Date?
                var urlMedia: String?
                var dec: Decodable?
                switch viewControllerData.name {
                case VIDEO:
                    let vimeoVideo: VimeoVideo = dataDec as! VimeoVideo
                    let privacy: Privacy = vimeoVideo.privacy!
                    let view: String = privacy.view!
                    if view == "anybody" {
                        let pictures = vimeoVideo.pictures!
                        let sectionData: VideoAppSectionJSONData = getAppSectionJSONData(name: viewControllerData.name!) as! VideoAppSectionJSONData
                        let vimeoSizeThumb: Int = sectionData.vimeo_size_thumb!
                        for size:Size in pictures.sizes! {
                            if(size.width == vimeoSizeThumb) {
                                imageUrl = size.link_with_play_button!
                                break
                            }
                        }
                        title = vimeoVideo.name != nil ? vimeoVideo.name : ""
                        desc = vimeoVideo.description != nil ? vimeoVideo.description : ""
                        date = vimeoVideo.release_time
                        urlMedia = vimeoVideo.link!
                        dec = vimeoVideo
                    } else {
                        id += 1
                        continue
                    }
                    
                case PHOTO:
                    let behanceProject: Project = dataDec as! Project
                    id = behanceProject.id!
                    title = behanceProject.name
                    desc = behanceProject.description == nil ? behanceProject.slug : behanceProject.description
                    imageUrl = behanceProject.covers?.k404
                    date = behanceProject.modified_on
                    urlMedia = behanceProject.url
                    dec = behanceProject
                case PHOTO_DETAILS:
                    let module: Module = dataDec as! Module
                    id = module.id!
                    title = module.source_filename == nil ? "" : module.source_filename
                    desc = "" //behanceProject.description == nil ? "" : behanceProject.description""
                    imageUrl = module.sizes.disp
                    date = Date()
                    urlMedia = module.sizes.original
                    dec = module
                default:
                    print("V&G_Project___<#name#> : ", self, "parseData")
                }
                cellData = VideoPhotoTableViewCellData(id: id, title: title!, imageUrl: imageUrl!, imagePathType: ImagePathType.url, desc: desc!, date: date!, urlMedia: urlMedia!)
                cellData?.dec = dec
                self.datas.append(cellData!)
                id += 1
            }
            
            // to add more cells to test photo section
            /*let limit: Int = 10
            if viewControllerData.name == PHOTO && IS_DEBUG_MODE && datas.count < limit {
                let data: VideoPhotoTableViewCellData = datas[0]
                datas = [VideoPhotoTableViewCellData]()
                for _ in 1...limit {
                    datas.append(data)
                }
            }*/
            
        } catch let jsonErr {
            print(jsonErr.localizedDescription)
        }
    }
    
    /*override func setBanSubtitle(sectionContentData: BaseAppSectionBanContentJSONData) {
        banView?.setSubtitle(text: String(datas.count) + " " + (Loc.getMultilingualText(mlText: sectionContentData.subtitles!)))
    }*/
    
}
