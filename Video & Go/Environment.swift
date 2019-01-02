//
//  Environment.swift
//  Video & Go
//
//  Created by Developer on 01/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation

public enum PlistKey {
    case EnvironmentType
    case ServerURL
    case TimeoutInterval
    case ConnectionProtocol
    
    func value() -> String {
        switch self {
        case .EnvironmentType:
            return "environment_type"
        case .ServerURL:
            return "server_url"
        case .TimeoutInterval:
            return "timeout_interval"
        case .ConnectionProtocol:
            return "protocol"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .EnvironmentType:
            return infoDict[PlistKey.EnvironmentType.value()] as! String
        case .ServerURL:
            return infoDict[PlistKey.ServerURL.value()] as! String
        case .TimeoutInterval:
            return infoDict[PlistKey.TimeoutInterval.value()] as! String
        case .ConnectionProtocol:
            return infoDict[PlistKey.ConnectionProtocol.value()] as! String
        }
    }
}

struct EnvironmentType {
    
    static let DEBUG: String = "debug"
    static let RELEASE: String = "release"
    
}
