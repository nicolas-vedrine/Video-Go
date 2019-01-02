//
//  AppData.swift
//  Video & Go
//
//  Created by Developer on 06/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

/// App Config based on VGBaseAppConfigJSONData
class AppConfigJSONData: VGBaseAppConfigJSONData {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        self.app = try? container.decode(AppJSONData.self, forKey: CodingKeys.app)
    }
    
}

class AppJSONData: VGBaseAppJSONData {
    
    enum SectionNames: String, Decodable {
        case home = "home"
        case video = "video"
        case video_details = "video_details"
        case photo = "photo"
        case photo_details = "photo_details"
    }
    
    required init(from decoder: Decoder) throws {
        //let container = try decoder.container(keyedBy: CodingKeys.self)
        try! super.init(from: decoder)
        self.sections = _getSections(decoder: decoder)
    }
    
}

extension AppJSONData {
    
    private func _getSections(decoder: Decoder) -> [VGBaseAppSectionJSONData] {
        var sections = [VGBaseAppSectionJSONData]()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            var sectionsArrayForName = try container.nestedUnkeyedContainer(forKey: CodingKeys.sections)
            var sectionsArray = sectionsArrayForName
            while(!sectionsArrayForName.isAtEnd)
            {
                let section = try sectionsArrayForName.nestedContainer(keyedBy: SectionNameKey.self)
                let name = try section.decode(SectionNames.self, forKey: SectionNameKey.name)
                switch name {
                case .home:
                    print("found home")
                    sections.append(try sectionsArray.decode(HomeAppSectionJSONData.self))
                case .video:
                    print("found video")
                    sections.append(try sectionsArray.decode(VideoAppSectionJSONData.self))
                case .video_details:
                    print("found video details")
                    sections.append(try sectionsArray.decode(VideoDetailsAppSectionJSONData.self))
                case .photo:
                    print("found photo")
                    sections.append(try sectionsArray.decode(PhotoAppSectionJSONData.self))
                case .photo_details:
                    print("found photo details")
                    sections.append(try sectionsArray.decode(PhotoDetailsAppSectionJSONData.self))
                }
            }
        } catch let error {
            print("V&G_Project____getSections : ", error)
        }
        return sections
    }
    
}

/// base content data for all main sections
class BaseAppSectionBanContentJSONData: VGBaseAppSectionContentJSONData {
    
    var ban_img_url: String?
    
    private enum BanKeys: String, CodingKey {
        case ban_img_url = "ban_img_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BanKeys.self)
        ban_img_url = try container.decode(String.self, forKey: BanKeys.ban_img_url)
        try super.init(from: decoder)
    }
    
}

/// data for home section
class HomeAppSectionJSONData: VGBaseAppSectionJSONData {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        self.content = try? container.decode(HomeAppSectionContentJSONData.self, forKey: CodingKeys.content)
    }
    
}

/// data for home section content, override base app content data to add the home content (video_url, etc)
class HomeAppSectionContentJSONData: VGBaseAppSectionContentJSONData {
    
    var video_url: String?
    var presentations: [PresentationJSONData]?
    
    private enum SerializationKeys: String, CodingKey {
        case video_url = "video_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SerializationKeys.self)
        video_url = try container.decode(String.self, forKey: SerializationKeys.video_url)
        try super.init(from: decoder)
        
        self.presentations = self._getPresentations(decoder: decoder)
    }
    
}

/// data for home section content extension to split the presentation logic
extension HomeAppSectionContentJSONData {
    
    private enum PresentationsKey: String, CodingKey {
        case presentations = "presentations"
    }
    
    private func _getPresentations(decoder: Decoder) -> [PresentationJSONData] {
        var presentations = [PresentationJSONData]()
        do {
            let container = try decoder.container(keyedBy: PresentationsKey.self)
            var presentationsArray = try container.nestedUnkeyedContainer(forKey: PresentationsKey.presentations)
            var index: Int = 0
            while(index < presentationsArray.count!)
            {
                presentations.append(try presentationsArray.decode(PresentationJSONData.self))
                index += 1
            }
        } catch let error {
            print("V&G_Project___HomeAppSectionContent : ", self, error)
        }
        return presentations
    }
    
}

/// presentation data in home content
struct PresentationJSONData: Decodable {
    
    var image_url: String?
    var text: VGBaseAppSectionMultilingualTextJSONData?
    
    private enum PresentationKeys: String, CodingKey {
        case image_url = "image_url"
        case text = "text"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PresentationKeys.self)
        self.image_url = try? container.decode(String.self, forKey: .image_url)
        self.text = try? container.decode(VGBaseAppSectionMultilingualTextJSONData.self, forKey: .text)
        print("V&G_Project___PresentationJSONData : ", self.text)
    }
    
}

/// data for video section
class VideoAppSectionJSONData: VGBaseAppSectionJSONData {
    
    var vimeo_size_thumb: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        try _setVimeoKeys(decoder: decoder)
        content = try? container.decode(BaseAppSectionBanContentJSONData.self, forKey: CodingKeys.content)
    }
    
}

extension VideoAppSectionJSONData {
    
    private enum VimeoKeys: String, CodingKey {
        case vimeo_size_thumb = "vimeo_size_thumb"
    }
    
    private func _setVimeoKeys(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: VimeoKeys.self)
        vimeo_size_thumb = try! container.decode(Int.self, forKey: VimeoKeys.vimeo_size_thumb)
    }
    
}

/// data for video details section
class VideoDetailsAppSectionJSONData: VGBaseAppSectionJSONData {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        content = try? container.decode(VGBaseAppSectionContentJSONData.self, forKey: CodingKeys.content)
    }
    
}

/// data for photo section
class PhotoAppSectionJSONData: VGBaseAppSectionJSONData {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        content = try? container.decode(BaseAppSectionBanContentJSONData.self, forKey: CodingKeys.content)
    }
    
}

/// data for photo detail section
class PhotoDetailsAppSectionJSONData: VGBaseAppSectionJSONData {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        content = try? container.decode(BaseAppSectionBanContentJSONData.self, forKey: CodingKeys.content)
    }
    
}
