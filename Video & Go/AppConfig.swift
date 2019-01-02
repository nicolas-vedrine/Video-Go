//
//  AppConfig.swift
//  Video & Go
//
//  Created by Developer on 23/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import UIKit

// BASIC

var IS_DEBUG_MODE: Bool = false
let BASE_URL_DEBUG: String = "http://192.168.0.40/videoandgo/www/"
let BASE_URL_PROD: String = "http://www.videoandgo.fr/"
var BASE_URL: String = BASE_URL_DEBUG
let CONFIG_PATH: String = "data/config"
var VERSION_NUMBER: String = ""
var BUILD_NUMBER: String = ""
var LOCALE: String = ""
var PREFERRED_LANGUAGES: String = ""

// VIEWS LIST
let HOME: String = "home"
let VIDEO: String = "video"
let VIDEO_DETAILS: String = "video_details"
let PHOTO: String = "photo"
let PHOTO_DETAILS: String = "photo_details"

// VIEW
let BACKGROUND_COLOR: UIColor = UIColor(red: 14 / 255, green: 14 / 255, blue: 19 / 255, alpha: 1)
let BLUE_COLOR: UIColor = UIColor(red: 15 / 255, green: 175 / 255, blue: 254 / 255, alpha: 1)
let WHITE_COLOR: UIColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1)
let LOGO_BLUE_COLOR: UIColor = UIColor(red: 96 / 255, green: 156 / 255, blue: 212 / 255, alpha: 1)

// TAB BAR
let TABBAR_BAR_TINT_COLOR: UIColor = UIColor(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 0.75)

// VIMEO
let VIMEO_URL: String = "https://api.vimeo.com/"
let VIMEO_CHANNELS_METHOD: String = "channels"
let VIMEO_VIDEOS_METHOD: String = "videos"
let VIDEO_AND_GO_CHANNEL_ID: String = "1401695"
let VIMEO_ACCESS_TOKEN: String = "25e7274d5bbfa8aae6b71620271490e7"
//let VIMEO_SIZE_THUMB: Int = 640

// BEHANCE
let BEHANCE_URL: String = "http://www.behance.net/v2/"
let BEHANCE_PROJECTS_METHOD: String = "projects"
let BEHANCE_USERS_METHOD: String = "users"
let BEHANCE_API_KEY: String = "rTV3Tq0lEkH028yxIhjlp9OBGCOAuJHD"
let COLLECTION_ID: String = "68807651"
let ADOBE_USER_NAME: String = "vedrinen80e4"

let THUMB_COMPONENT_SIZE_URL: String = "disp"
