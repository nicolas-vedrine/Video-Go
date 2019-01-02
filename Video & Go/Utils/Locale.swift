//
//  Locale.swift
//  Video & Go
//
//  Created by Developer on 10/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation


extension Locale {
    
    static public func getLocale() -> String {
        var localeString: String?
        let languageCode = Locale.current.languageCode
        if languageCode != LanguageCode.fr.rawValue && languageCode != LanguageCode.en.rawValue && languageCode != LanguageCode.es.rawValue {
            localeString = LanguageCode.fr.rawValue
        }else {
            return Locale.current.languageCode!
        }
        return localeString!
    }
    
}

enum LanguageCode: String {
    case fr = "fr"
    case en = "en"
    case es = "es"
    case de = "de"
    case ja = "ja"
    case ca = "ca"
}

class Loc {
    
    static public func getMultilingualText(mlText: VGBaseAppSectionMultilingualTextJSONData) -> String {
        let languageCode = Locale.current.languageCode
        var text: String?
        /*switch languageCode {
        case LanguageCode.fr.rawValue:
            text = mlText.fr
        case LanguageCode.en.rawValue:
            text = mlText.en
        case LanguageCode.es.rawValue:
            text = mlText.es
        default:
            text = mlText.fr
        }*/
        text = mlText.fr
        return text!
    }
    
    static public func getTimeAgoString(timeAgoObj: TimeAgoObject, time: Time) -> String {
        let timeAgoObjTimeSring = String(timeAgoObj.time)
        let stringSearched: String = " -- "
        var timeString: String
        switch timeAgoObj.type {
        case Date.TimeAgoType.second:
            timeString = Loc.getMultilingualText(mlText: (time.second)!)
        case Date.TimeAgoType.minute:
            timeString = Loc.getMultilingualText(mlText: (time.minute)!)
        case Date.TimeAgoType.hour:
            timeString = Loc.getMultilingualText(mlText: (time.hour)!)
        case Date.TimeAgoType.day:
            timeString = Loc.getMultilingualText(mlText: (time.day)!)
        case Date.TimeAgoType.week:
            timeString = Loc.getMultilingualText(mlText: (time.week)!)
        case Date.TimeAgoType.mouth:
            timeString = Loc.getMultilingualText(mlText: (time.mouth)!)
        case Date.TimeAgoType.year:
            timeString = Loc.getMultilingualText(mlText: (time.year)!)
        default:
            print("V&G_Project___<#name#> : ", self)
        }
        var finalText: String = ""
        if timeString.contains(stringSearched) {
            let timeStringSplit = timeString.components(separatedBy: " -- ")
            finalText = timeStringSplit[0] + " " + timeAgoObjTimeSring + " " + timeStringSplit[1]
        }else {
            finalText = timeAgoObjTimeSring + " " + timeString
        }
        return finalText
    }
    
}
