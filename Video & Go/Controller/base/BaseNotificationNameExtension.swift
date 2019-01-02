//
//  BaseNotificationNameExtension.swift
//  Video & Go
//
//  Created by Developer on 26/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    //CONFIG
    static let CONFIG_LOAD_START_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.configLoadStart")
    static let CONFIG_LOAD_FINISHED_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.configLoadFinished")
    
    // VIEW
    static let VIEW_OPEN_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.viewOpen")
    static let VIEW_END_OPEN_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.viewEndOpen")
    
    static let VIEW_CLOSE_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.viewClose")
    static let VIEW_END_CLOSE_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.viewEndClose")
    
    // loading
    static let LOADING_START_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.loadingStart")
    static let LOADING_FINISHED_NOTIFICATION = Notification.Name(rawValue: "fr.videoandgo.loadingFinished")
    
    // SCREEN PROTECTOR
    static let SCREEN_PROTECTOR_ON = Notification.Name(rawValue: "fr.videoandgo.screenProtectorOn")
    static let SCREEN_PROTECTOR_OFF = Notification.Name(rawValue: "fr.videoandgo.screenProtectorOff")
    
}
