//
//  BasicViewController.swift
//  TestBehanceProject
//
//  Created by Developer on 19/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class VGBaseViewController: UIViewController {

    internal var viewControllerData: VGBaseViewControllerData = VGBaseViewControllerData()
    internal var observers: [NSObjectProtocol] = [NSObjectProtocol]()
    internal var loadingController: VGBasePreloadingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("V&G___viewDidAppear : ", self)
        super .viewDidAppear(animated)
        
        addObservers()
    }
    
    internal func buildLoading(loadingStyle: LoadingStyle = LoadingStyle.ACTIVITY_INDICATOR, bgColor: UIColor = UIColor(white: 0, alpha: 0.7)) -> Void {
        loadingController = VGBasePreloadingController(loadingStyle: loadingStyle, bgColor: bgColor)
        loadingController?.view.alpha = 0.0
        
        let originalTransform = loadingController?.indicView.transform
        let scaledTransform = originalTransform?.scaledBy(x: 1.0, y: 1.0)
        let scaledAndTranslatedTransform = scaledTransform?.translatedBy(x: 0.0, y: 50.0)
        UIView.animate(withDuration: IS_DEBUG_MODE ? 0.2 : 1, animations: {
            self.loadingController?.indicView.transform = scaledAndTranslatedTransform!
         })
    }
    
    internal func showLoading() {
        view.addSubview((loadingController?.view)!)
        view.bringSubview(toFront: (loadingController?.view)!)
        loadingController?.view.frame = view.frame
        loadingController?.didMove(toParentViewController: self)
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingController?.view.alpha = 1.0
        }) { (finished) in
            
        }
    }
    
    func loadUrl(urlString: String, isShowLoading: Bool = true) -> Void {
        if isShowLoading {
            showLoading()
        }
        
        let url: URL = URL(string: urlString)!
        print("V&G_FW___loadUrl : ", self, url)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (IS_DEBUG_MODE ? 0.5 : 2)) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else
                {
                    print("V&G_FW___loadUrl : ", self, "url no good : ", url)
                    return
                }
                self.onLoadUrlFinished(data: data)
                }.resume()
        }
    }
    
    internal func onLoadUrlFinished(data: Data) {
        print("V&G_FW___onLoadUrlFinished : ", self, data.toString())
        DispatchQueue.main.async { [unowned self] in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.loadingController?.view.alpha = 0.0
            }) { (finished) in
                self.onLoadUrlAnimationFinished(data: data)
            }
            
        }
    }
    
    internal func onLoadUrlAnimationFinished(data: Data) {
        self.loadingController?.willMove(toParentViewController: nil)
        self.loadingController?.view.removeFromSuperview()
        self.loadingController?.removeFromParentViewController()
        self.dispatchLoadingFinished(data: data)
    }
    
    internal func dispatchLoadingFinished(data: Data) -> Void {
        print("V&G_FW___dispatchLoadingFinished : ", self)
        NotificationCenter.default.post(name: .LOADING_FINISHED_NOTIFICATION, object: data)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("V&G___viewDidDisappear : ", self)
        removeObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func buildView() {
        view.isHidden = false
        print("V&G___buildView : ", self)
    }
    
    internal func addObservers() {
        print("V&G___addObservers", self)
        
        let applicationDidEnterBackground = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) { (notification) in
            self.onApplicationDidEnterBackground(notification: notification)
        }
        
        let applicationDidEnterForeground = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillEnterForeground, object: nil, queue: nil) { (notification) in
            self.onApplicationWillEnterForeground(notification: notification)
        }
        
        observers.append(applicationDidEnterBackground)
        observers.append(applicationDidEnterForeground)
    }
    
    internal func onApplicationDidEnterBackground(notification: Notification) {
        print("V&G_Project___onApplicationDidEnterBackground : ", self)
    }
    
    internal func onApplicationWillEnterForeground(notification: Notification) {
        print("V&G_Project___onApplicationWillEnterForeground : ", self)
    }
    
    internal func removeObservers() {
        print("V&G___removeObservers : ", self)
        for observer: NSObjectProtocol in observers {
            NotificationCenter.default.removeObserver(observer)
        }
        observers.removeAll()
    }
    
    func open(_ controller: UIViewController, _ target: UIViewController) -> Void {
        print("V&G___open : ", self)
        
        view.isHidden = false
        
        target.present(controller, animated: true, completion: {
            self.onEndOpen(controller, target)
        })
        
        NotificationCenter.default.post(name: .VIEW_OPEN_NOTIFICATION, object: target)
        if(viewControllerData.isScreenProtected)! {
            NotificationCenter.default.post(name: .SCREEN_PROTECTOR_ON, object: target)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    internal func onEndOpen(_ controller: UIViewController, _ target: UIViewController) {
        if(viewControllerData.isScreenProtected)! {
            NotificationCenter.default.post(name: .SCREEN_PROTECTOR_OFF, object: self)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        NotificationCenter.default.post(name: .VIEW_END_OPEN_NOTIFICATION, object: self)
    }
    
    func close() -> Void {
        print("V&G___close : ", self)
        print(observers.count)
        if(viewControllerData.isScreenProtected)! {
            NotificationCenter.default.post(name: .SCREEN_PROTECTOR_ON, object: self)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        self.dismiss(animated: false, completion: {
            self.onEndClose()
        })
        //view.isHidden = true
        //self.dismiss(animated: true, completion: nil)
    }
    
    internal func onEndClose() {
        print("V&G___onEndClose : ", self)
        view.isHidden = false
        NotificationCenter.default.post(name: .VIEW_END_CLOSE_NOTIFICATION, object: self)
        if(viewControllerData.isScreenProtected)! {
            NotificationCenter.default.post(name: .SCREEN_PROTECTOR_OFF, object: self)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class VGBaseAppSectionController: VGBaseViewController {
    
    override func loadView() {
        setSectionName()
        
        super.loadView()
    }
    
    internal func setSectionName() {
        print("V&G_FW___setSectionName : ", self, viewControllerData.name as Any)
    }
    
    internal func getAppSectionJSONData(name: String) -> VGBaseAppSectionJSONData? {
        let configData = VGBaseAppModel.sharedInstance.configData
        let app = configData?.app
        let sections = app?.sections
        for sectionJSONData in sections! {
            if(sectionJSONData.name == name){
                return sectionJSONData
            }
        }
        return nil
    }
    
}
