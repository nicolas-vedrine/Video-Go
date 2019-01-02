//
//  HeaderView.swift
//  Video & Go
//
//  Created by Developer on 30/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

class HeaderView: VGBaseNibView {

    @IBOutlet weak var btnMail: UIButton!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnVimeo: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    var onClose: (() -> ())?
    
    @IBOutlet weak var btnCloseHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("V&G_Project___init : ", self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func buildView() {
        super.buildView()
        
        //self.btnCloseHeightConstraint.constant -= 1
        self.layoutIfNeeded()
        
        //if !IS_DEBUG_MODE {
            btnClose.isHidden = true
        //} 
    }
    
    @IBAction func btnAction(_ sender: Any) {
        let button: UIButton = sender as! UIButton
        //print("V&G_Project___btnAction : ", self, button)
        if button == btnClose {
            onClose?()
        }
    }
    
    public func showClose() {
        
        /*self.btnClose.isHidden = false
        self.btnClose.alpha = 0.0
        
        UIView.animate(withDuration: 1.0, animations: {
            self.btnCloseHeightConstraint.constant += 7
            self.layoutIfNeeded()
        }) { (progress) in
            self._onAnimeProgress()
        }
        
        UIView.animate(withDuration: 1.5, animations: {
            self.btnClose.alpha = 1.0
        }) { (finished) in
            //self._onAnimeFinished()
        }*/
        
        /*UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)*/
    }
    
    private func _onAnimeProgress() {
        
        print("V&G_Project____onAnimeProgress : ", self)
    }
    
    private func _onAnime() {
        print("V&G_Project____onAnime() : ", self)
    }
    
    public func hideClose() {
        
    }
    
    
    

}
