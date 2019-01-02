//
//  AppData.swift
//  Video & Go
//
//  Created by Developer on 06/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

class ConfigData: VGBaseJSONData {
    
    let sections: [VGBaseAppSection]
    
    enum SectionsKey: CodingKey {
        case sections
    }
    
    enum SectionNameKey: CodingKey {
        case name
    }
    
    enum SectionNames: String, Decodable {
        case home = "home"
        case video = "video"
        case video_details = "video_details"
        case photo = "photo"
        case photo_details = "photo_details"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SectionsKey.self)
        var sectionsArrayForName = try container.nestedUnkeyedContainer(forKey: SectionsKey.sections)
        var sections = [VGBaseAppSection]()
        
        var sectionsArray = sectionsArrayForName
        while(!sectionsArrayForName.isAtEnd)
        {
            let section = try sectionsArrayForName.nestedContainer(keyedBy: SectionNameKey.self)
            let name = try section.decode(SectionNames.self, forKey: SectionNameKey.name)
            switch name {
            case .home:
                print("found home")
                sections.append(try sectionsArray.decode(HomeAppSection.self))
            case .video:
                print("found video")
                sections.append(try sectionsArray.decode(VideoAppSection.self))
            case .video_details:
            print("found video details")
            sections.append(try sectionsArray.decode(VideoDetailsAppSection.self))
            case .photo:
                print("found photo")
                sections.append(try sectionsArray.decode(PhotoAppSection.self))
            case .photo_details:
                print("found photo details")
                sections.append(try sectionsArray.decode(PhotoDetailsAppSection.self))
        }
        }
        self.sections = sections
        try super.init(from: decoder)
    }
    
}

class HomeAppSection: VGBaseAppSection {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        content = try? container.decode(HomeAppSectionContent.self, forKey: CodingKeys.content)
    }
    
}

class HomeAppSectionContent: VGBaseAppSectionContent {
    
    var video_url: String?
    var presentations: [Presentation]?
    
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

extension HomeAppSectionContent {
    
    private enum PresentationsKey: String, CodingKey {
        case presentations = "presentations"
    }
    
    private enum PresentationsIdKey: CodingKey {
        case id
    }
    
    private enum PresentationIds: Int, Decodable {
        case k0 = 0
        case k1 = 1
        case k2 = 2
    }
    
    private func _getPresentations(decoder: Decoder) -> [Presentation] {
        var presentations = [Presentation]()
        do {
            let container = try decoder.container(keyedBy: PresentationsKey.self)
            let presentationsArray = try container.nestedUnkeyedContainer(forKey: PresentationsKey.presentations)
            var presentationsCopyArray = presentationsArray
            var index: Int = 0
            while(index < presentationsArray.count!)
            {
                print("V&G_Project___<#name#> : ", self, index)
                //let presentation = try presentationsArray.nestedContainer(keyedBy: PresentationsIdKey.self)
                //let id = try presentation.decode(PresentationIds.self, forKey: PresentationsIdKey.id)
                //print("V&G_Project___<#name#> : ", id)
                presentations.append(try presentationsCopyArray.decode(Presentation.self))
                index = index + 1
            }
            //self.presentations = try? container.decode(Presentation.self, forKey: PresentationsKey.presentations)
        } catch let error {
            print("V&G_FW___<#name#> : ", self, error)
        }
        return presentations
    }
    
}

struct Presentation: Decodable {
    
    var image_url: String?
    var text: VGBaseAppSectionMultilingualText?
    
    private enum PresentationKeys: String, CodingKey {
        case image_url = "image_url"
        case text = "text"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PresentationKeys.self)
        self.image_url = try? container.decode(String.self, forKey: .image_url)
        self.text = try? container.decode(VGBaseAppSectionMultilingualText.self, forKey: .text)
    }
    
}

class VideoAppSection: VGBaseAppSection {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        
        content = try? container.decode(VideoAppSectionContent.self, forKey: CodingKeys.content)
    }
    
}

class VideoAppSectionContent: VGBaseAppSectionContent {
    
    
    
}

class VideoDetailsAppSection: VGBaseAppSection {
    
    
    
}

class PhotoAppSection: VGBaseAppSection {
    
    
    
}

class PhotoDetailsAppSection: VGBaseAppSection {
    
    
    
}

/*class Drink: Decodable {
 var type: String
 var description: String
 
 private enum CodingKeys: String, CodingKey {
 case type
 case description
 }
 }
 
 
 class Beer: Drink {
 var alcohol_content: String
 
 private enum CodingKeys: String, CodingKey {
 case alcohol_content
 }
 
 required init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: CodingKeys.self)
 self.alcohol_content = try container.decode(String.self, forKey: .alcohol_content)
 try super.init(from: decoder)
 }
 }*/
