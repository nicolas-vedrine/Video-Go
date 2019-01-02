//
//  VimeoVideo.swift
//  TestVimeoChannel
//
//  Created by Developer on 04/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

struct VimeoData: Decodable {
    
    let total: Int?
    let page: Int?
    let per_page: Int?
    let data: [VimeoVideo]?
    
}

/*struct VimeoVideo: Decodable {
    
    let uri: String?
    let name: String?
    let description: String?
    let link: String?
    let duration: Int?
    let pictures: Picture?
    let created_time: String?
    let modified_time: String?
    let release_time: String?
    
}*/

struct VimeoVideo: Decodable {
    
    var uri: String?
    var name: String?
    var description: String?
    var link: String?
    var duration: Int?
    var privacy: Privacy?
    var pictures: Picture?
    var created_time: Date?
    var modified_time: Date?
    var release_time: Date?
    
    private enum CodingKeys: String, CodingKey {
        case uri = "uri"
        case name = "name"
        case description = "description"
        case link = "link"
        case duration = "duration"
        case privacy = "privacy"
        case pictures = "pictures"
        case created_time = "created_time"
        case modified_time = "modified_time"
        case release_time = "release_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uri = try? container.decode(String.self, forKey: CodingKeys.uri)
        self.name = try? container.decode(String.self, forKey: CodingKeys.name)
        self.description = try? container.decode(String.self, forKey: CodingKeys.description)
        self.link = try? container.decode(String.self, forKey: CodingKeys.link)
        self.duration = try? container.decode(Int.self, forKey: CodingKeys.duration)
        self.privacy = try? container.decode(Privacy.self, forKey: CodingKeys.privacy)
        self.pictures = try? container.decode(Picture.self, forKey: CodingKeys.pictures)
        self.created_time = _getDate(dateString: try! container.decode(String.self, forKey: CodingKeys.created_time))
        self.modified_time = _getDate(dateString: try! container.decode(String.self, forKey: CodingKeys.modified_time))
        self.release_time = _getDate(dateString: try! container.decode(String.self, forKey: CodingKeys.release_time))
    }
    
}

extension VimeoVideo {
    
    private func _getDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter.date(from: dateString)!
    }
    
}

struct Privacy: Decodable {
    
    let view: String?
    
}

struct Picture: Decodable {
    
    let uri: String?
    let sizes: [Size]?
    
}

struct Size: Decodable {
    
    let width: Int?
    let height: Int?
    let link: String?
    let link_with_play_button: String?
    
}
