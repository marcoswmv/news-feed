//
//  UILabel+LetterSpacing.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 26.08.2021.
//

import UIKit

extension NSAttributedString {
    
    var entireRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
}

extension UILabel {
    
    fileprivate func addAttribute(_ key: NSAttributedString.Key, value: Any) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.addAttribute(key, value: value, range: attributedText.entireRange)
            self.attributedText = mutableAttributedText
        } else {
            self.attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
        }
    }
    
    fileprivate func removeAttribute(_ key: NSAttributedString.Key) {
        if let attributedText = attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedText.removeAttribute(key, range: attributedText.entireRange)
            self.attributedText = mutableAttributedText
        }
    }
    
    fileprivate func setAttribute(_ key: NSAttributedString.Key, value: Any?) {
        if let value = value {
            addAttribute(key, value: value)
        } else {
            removeAttribute(key)
        }
    }
    
    fileprivate var attributes: [NSAttributedString.Key: Any]? {
        if let attributedText = attributedText {
            return attributedText.attributes(at: 0, effectiveRange: nil)
        } else {
            return nil
        }
    }
    
    fileprivate func getAttribute<AttributeType>(_ key: NSAttributedString.Key) -> AttributeType? {
        return attributes?[key] as? AttributeType
    }
    
    public var letterSpacing: CGFloat? {
        get { getAttribute(.kern) }
        set { setAttribute(.kern, value: newValue) }
    }
}
