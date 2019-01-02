//
//  AppTabBarController.swift
//  Video & Go
//
//  Created by Developer on 27/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    private let _selectedColor: UIColor = LOGO_BLUE_COLOR
    private let _unselectedColor: UIColor = BACKGROUND_COLOR

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = true
        
        UITabBar.appearance().tintColor = _selectedColor
        
        _buildTabBar()

        selectedIndex = IS_DEBUG_MODE ? 0 : 0
    }
    
    private func _buildTabBar() {
        let configData = AppModel.sharedInstance.configData
        let tabBarData = configData?.app?.tabbar
        let items = tabBarData?.items
        var index: Int = 0
        let tabBarItems = tabBar.items
        for item in items! {
            let tabBarItem = tabBarItems![index]
            tabBarItem.title = Loc.getMultilingualText(mlText: item.titles!)
            let unselectedImage: UIImage = (UIImage(named: item.icon!)?.withRenderingMode(.alwaysOriginal))!
            let coloredUnselectedImage: UIImage = unselectedImage.maskWithColor(color: _unselectedColor)!
            let selectedImage: UIImage = (UIImage(named: item.icon!)?.withRenderingMode(.alwaysOriginal))!
            let coloredSelectedImage = selectedImage.maskWithColor(color: _selectedColor)!
            tabBarItem.image = coloredUnselectedImage
            tabBarItem.selectedImage = coloredSelectedImage
            index += 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
