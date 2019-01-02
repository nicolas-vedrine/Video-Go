//
//  Types.swift
//  Video & Go
//
//  Created by Developer on 05/11/2018.
//  Copyright © 2018 Nicolas VEDRINE. All rights reserved.
//

import Foundation
import UIKit

extension Data
{
    func toString() -> String
    {
        return String(data: self, encoding: .utf8)!
    }
}

extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
    
    func toDateFromTimeStamp() -> Date {
        let double = Double(self)
        let date = Date(timeIntervalSince1970: double!)
        return date
    }
    
}

extension Int {
    
    func toTimeFormatted(digits: Int = 1) -> String {
        var digitsString: String = ""
        var timeFormatted: String = ""
        if self < 10 {
            for _ in 1...digits {
                digitsString += "0"
            }
        }
        timeFormatted = digitsString + String(self)
        return timeFormatted
    }
    
}

extension Date {
    
    func timeAgoObj() -> TimeAgoObject {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        var timeAgoObject: TimeAgoObject?
        
        if secondsAgo < minute {
            timeAgoObject = TimeAgoObject(time: secondsAgo, type: TimeAgoType.second)
            //return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            timeAgoObject = TimeAgoObject(time: secondsAgo / minute, type: TimeAgoType.minute)
            //return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            timeAgoObject = TimeAgoObject(time: secondsAgo / hour, type: TimeAgoType.hour)
            //return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            timeAgoObject = TimeAgoObject(time: secondsAgo / day, type: TimeAgoType.day)
            //return "\(secondsAgo / day) days ago"
        }else {
            timeAgoObject = TimeAgoObject(time: secondsAgo / week, type: TimeAgoType.week)
            //return "\(secondsAgo / week) weeks ago"
        }
        return timeAgoObject!
    }
    
    enum TimeAgoType: String {
        case second = "second"
        case minute = "minute"
        case hour = "hour"
        case day = "day"
        case week = "week"
        case mouth = "mouth"
        case year = "year"
    }
    
    func toFormat(format: DateFormatType = DateFormatType.fr_FR_day, style: DateFormatter.Style = DateFormatter.Style.long, locale: LanguageCode = LanguageCode.fr) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = style
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: locale.rawValue)
        return formatter.string(from: self)
    }
    
    func toString() -> String {
        let formatterToString = DateFormatter()
        return formatterToString.string(from: self)
    }
    
}

struct TimeAgoObject {
    var time: Int
    var type: Date.TimeAgoType
}

enum DateFormatType: String {
    
    case fr_FR_day = "EEEE dd MMMM YYYY"
    case fr_FR_hour = "HH:mm"
    
}

extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func findConstraint(layoutAttribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }
    
    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutAttribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
    
    func getConstraint(forAttribute attribute:NSLayoutAttribute)->NSLayoutConstraint?{
        for aConstraint in constraints{
            if aConstraint.firstAttribute == attribute{
                return aConstraint
            }
        }
        return nil
    }
}

extension UIImage
{
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    
    }
    
    enum SizeComponent {
        case width(CGFloat)
        case height(CGFloat)
        
        var rawValue: CGFloat {
            switch self {
            case .width(let width):
                return width
            case .height(let height):
                return height
            }
        }
    }
    
    // MARK: Scale Image To Given Width/Height
    
    func scaled(to sizeComponent: SizeComponent, opaque: Bool = false) -> UIImage {
        
        var scale: CGFloat
        
        switch  sizeComponent {
        case .width(let width):
            scale = width / size.width
        case .height(let height):
            scale = height / size.height
        }
        
        let newHeight = size.height * scale
        let newWidth = sizeComponent.rawValue
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}
