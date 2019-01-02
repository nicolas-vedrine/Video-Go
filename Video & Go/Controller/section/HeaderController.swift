//
//  HeaderController.swift
//  Video & Go
//
//  Created by Developer on 23/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class HeaderController: BaseViewController {

   
    @IBOutlet weak var btnMail: UIButton!
    //@IBOutlet weak var btnPhone: UIButton!
    
    override func buildView() {
        super.buildView()
        
        view.backgroundColor = UIColor.clear
    }
    
    
    @IBAction func btnMailAction(_ sender: Any) {
        print("btnMailAction")
        NotificationCenter.default.post(name: .LOADING_START_NOTIFICATION, object: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // change 2 to desired number of seconds
            NotificationCenter.default.post(name: .LOADING_FINISHED_NOTIFICATION, object: self)
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
