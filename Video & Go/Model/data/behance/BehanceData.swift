//
//  BehanceProjects.swift
//  TestBehanceProject
//
//  Created by Developer on 11/10/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

struct BehanceProjects: Decodable {
    
    let projects: [Project]
    
}

struct BehanceProject: Decodable {
    
    let project: Project
    
}

struct Project: Decodable {
    
    var id: Int?
    var name: String?
    var published_on: Date?
    var created_on: Date?
    var modified_on: Date?
    var description: String?
    var url: String?
    var slug: String?
    var covers: Cover?
    var modules: [Module]?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case published_on = "published_on"
        case created_on = "created_on"
        case modified_on = "modified_on"
        case description = "description"
        case url = "url"
        case slug = "slug"
        case covers = "covers"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: CodingKeys.id)
        self.name = try? container.decode(String.self, forKey: CodingKeys.name)
        self.published_on = _getDate(dateInt: try! container.decode(Int.self, forKey: CodingKeys.published_on))
        self.created_on = _getDate(dateInt: try! container.decode(Int.self, forKey: CodingKeys.created_on))
        self.modified_on = _getDate(dateInt: try! container.decode(Int.self, forKey: CodingKeys.modified_on))
        self.description = try? container.decode(String.self, forKey: CodingKeys.description)
        self.url = try? container.decode(String.self, forKey: CodingKeys.url)
        self.slug = try? container.decode(String.self, forKey: CodingKeys.slug)
        self.covers = try? container.decode(Cover.self, forKey: CodingKeys.covers)
        print("V&G_Project___VimeoVideo : ", self)
        self.modules = _getModules(decoder: decoder)
    }
    
}

extension Project {
    
    private enum ModulesKey: String, CodingKey {
        case modules = "modules"
    }
    
    private func _getModules(decoder: Decoder) -> [Module] {
        var modules = [Module]()
        do {
            let container = try decoder.container(keyedBy: ModulesKey.self)
            let modulesString = try? container.nestedUnkeyedContainer(forKey: ModulesKey.modules)
            if modulesString != nil {
                var modulesArray = try! container.nestedUnkeyedContainer(forKey: ModulesKey.modules)
                print("V&G_Project____getModules : ", self, modulesArray)
                var index: Int = 0
                while(index < modulesArray.count!)
                {
                    modules.append(try modulesArray.decode(Module.self))
                    index += 1
                }
            }
        } catch let error {
            print("V&G_Project___Project : ", self, error)
        }
        return modules
    }
    
    private func _getDate(dateInt: Int) -> Date {
        let dateString: String = String(dateInt)
        let date: Date = dateString.toDateFromTimeStamp()
        return date
    }
    
}

struct Cover: Decodable {
    
    private enum SerializationKeys: String, CodingKey {
        case k115 = "115"
        case k202 = "202"
        case k230 = "230"
        case k404 = "404"
        case k808 = "808"
        case original = "original"
        case max_808 = "max_808"
    }
    
    var k115: String?
    var k202: String?
    var k230: String?
    var k404: String?
    var k808: String?
    var original: String?
    var max_808: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SerializationKeys.self)
        k115 = try? container.decode(String.self, forKey: SerializationKeys.k115)
        k202 = try? container.decode(String.self, forKey: SerializationKeys.k202)
        k230 = try? container.decode(String.self, forKey: SerializationKeys.k230)
        k404 = try? container.decode(String.self, forKey: SerializationKeys.k404)
        k808 = try? container.decode(String.self, forKey: SerializationKeys.k808)
        original = try? container.decode(String.self, forKey: SerializationKeys.original)
        max_808 = try? container.decode(String.self, forKey: SerializationKeys.max_808)
    }
    
}

struct Module: Decodable {
    
    let id: Int?
    let dimensions: Dimensions?
    let sizes: BehanceSize
    let src: String?
    let source_filename: String?
    
}

struct Component: Decodable {
    
    let id: Int?
    let dimensions: Dimensions?
    let sizes: BehanceSize
    let src: String?
    let source_filename: String?
}

struct Dimensions: Decodable {
    
    private enum SerializationKeys: String, CodingKey {
        case k1400 = "1400"
        case source = "source"
        case disp = "disp"
        case hd = "hd"
        case fs = "fs"
        case max_1200 = "max_1200"
        case max_3840 = "max_3840"
    }
    
    var k1400: Dimension?
    var source: Dimension?
    var disp: Dimension?
    var hd: Dimension?
    var fs: Dimension?
    var max_1200: Dimension?
    var max_3840: Dimension?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SerializationKeys.self)
        k1400 = try? container.decode(Dimension.self, forKey: SerializationKeys.k1400)
        source = try? container.decode(Dimension.self, forKey: SerializationKeys.source)
        disp = try? container.decode(Dimension.self, forKey: SerializationKeys.disp)
        hd = try? container.decode(Dimension.self, forKey: SerializationKeys.hd)
        fs = try? container.decode(Dimension.self, forKey: SerializationKeys.fs)
        max_1200 = try? container.decode(Dimension.self, forKey: SerializationKeys.max_1200)
        max_3840 = try? container.decode(Dimension.self, forKey: SerializationKeys.max_3840)
    }
    
}

struct Dimension: Decodable {
    
    let width: Int?
    let height: Int?
    
}

struct BehanceSize: Decodable {
    
    private enum SerializationKeys: String, CodingKey {
        case k1400 = "1400"
        case source = "source"
        case disp = "disp"
        case hd = "hd"
        case fs = "fs"
        case max_1200 = "max_1200"
        case max_3840 = "max_3840"
        case original = "original"
    }
    
    var k1400: String?
    var source: String?
    var disp: String?
    var hd: String?
    var fs: String?
    var max_1200: String?
    var max_3840: String?
    var original: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SerializationKeys.self)
        k1400 = try? container.decode(String.self, forKey: SerializationKeys.k1400)
        source = try? container.decode(String.self, forKey: SerializationKeys.source)
        disp = try? container.decode(String.self, forKey: SerializationKeys.disp)
        hd = try? container.decode(String.self, forKey: SerializationKeys.hd)
        fs = try? container.decode(String.self, forKey: SerializationKeys.fs)
        max_1200 = try? container.decode(String.self, forKey: SerializationKeys.max_1200)
        max_3840 = try? container.decode(String.self, forKey: SerializationKeys.max_3840)
        original = try? container.decode(String.self, forKey: SerializationKeys.original)
    }
    
}
