//
//  BaseData.swift
//  Video & Go
//
//  Created by Developer on 29/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

class VGBaseData {
    
    var id: Int?
    var dec: Decodable?
    
    init(id: Int) {
        self.id = id
    }
    
}

/// VGBase class for JSON data
class VGBaseJSONData: Decodable {
    
    var id: Int?
    
}

/// VGBase class for app config JSON data
class VGBaseAppConfigJSONData: VGBaseJSONData {
    
    // app languge
    var language: VGBaseLanguageJSONData?
    
    var app: VGBaseAppJSONData?
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case app = "app"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.language = try? container.decode(VGBaseLanguageJSONData.self, forKey: CodingKeys.language)
        self.app = try? container.decode(VGBaseAppJSONData.self, forKey: CodingKeys.app)
        try super.init(from: decoder)
    }
    
}

class VGBaseAppJSONData: Decodable {
    
    // app tabbar
    var tabbar: VGBaseTabBarJSONData?
    
    // app setions
    var sections: [VGBaseAppSectionJSONData]?
    
    enum CodingKeys:String, CodingKey {
        case tabbar = "tabbar"
        case sections = "sections"
    }
    
    enum SectionNameKey: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //self.sections = try? container.decode(VGBaseLanguageJSONData.self, forKey: CodingKeys.sections)
        self.tabbar = try container.decode(VGBaseTabBarJSONData.self, forKey: CodingKeys.tabbar)
    }
    
}

struct VGBaseTabBarJSONData: Decodable {
    
    let items: [VGBaseTabBarItemJSONData]?
    
}

struct VGBaseTabBarItemJSONData: Decodable {
    
    let name: String?
    let titles: VGBaseAppSectionMultilingualTextJSONData?
    let icon: String?
    
}

struct VGBaseLanguageJSONData: Decodable {
    
    let time: Time?
    
}

struct Time: Decodable {
    
    let second: VGBaseAppSectionMultilingualTextJSONData?
    let minute: VGBaseAppSectionMultilingualTextJSONData?
    let hour: VGBaseAppSectionMultilingualTextJSONData?
    let day: VGBaseAppSectionMultilingualTextJSONData?
    let week: VGBaseAppSectionMultilingualTextJSONData?
    let mouth: VGBaseAppSectionMultilingualTextJSONData?
    let year: VGBaseAppSectionMultilingualTextJSONData?
    
}

/// VGBase class for app section JSON data
class VGBaseAppSectionJSONData: VGBaseJSONData {
    
    var name: String?
    var content: VGBaseAppSectionContentJSONData?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case content = "content"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.content = try container.decode(VGBaseAppSectionContentJSONData.self, forKey: .content)
        try super.init(from: decoder)
    }
    
}

/// VGBase class for app section content JSON data
class VGBaseAppSectionContentJSONData: Decodable {
    
    var titles: VGBaseAppSectionMultilingualTextJSONData?
    var subtitles: VGBaseAppSectionMultilingualTextJSONData?
    var content_name: String?
    
    enum CodingKeys: String, CodingKey {
        case content_name = "content_name"
        case titles = "titles"
        case subtitles = "subtitles"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content_name = try? container.decode(String.self, forKey: .content_name)
        self.titles = try? container.decode(VGBaseAppSectionMultilingualTextJSONData.self, forKey: .titles)
        self.subtitles = try? container.decode(VGBaseAppSectionMultilingualTextJSONData.self, forKey: .subtitles)
    }
    
}

/// VGBase struct for multilingual text JSON data
struct VGBaseAppSectionMultilingualTextJSONData: Decodable {
    
    private enum MultilingualKeys: String, CodingKey {
        case fr = "fr"
        case en = "en"
        case es = "es"
    }
    
    var fr: String?
    var en: String?
    var es: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MultilingualKeys.self)
        fr = try? container.decode(String.self, forKey: MultilingualKeys.fr)
        en = try? container.decode(String.self, forKey: MultilingualKeys.en)
        es = try? container.decode(String.self, forKey: MultilingualKeys.es)
    }
    
}
