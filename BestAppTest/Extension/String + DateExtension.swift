//
//  StringExtension.swift
//  BestAppTest
//
//  Created by Карим Садыков on 30.11.2022.
//

import Foundation

extension String {
    
    var isNonEmpty:Bool {
        return !isEmpty
    }
    
    func toDate() -> Date? {
        return Date.inputFormatter.date(from: self)
    }
}

extension Date {
    
    static var inputFormatter:DateFormatter {
        let frm = DateFormatter()
        frm.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        return frm
    }
    
    static var outputFormatter:DateFormatter {
        let frm = DateFormatter()
        frm.dateFormat = "yyyy-MM-dd"
        return frm
    }
    
    func toString() -> String {
        return Date.outputFormatter.string(from: self)
    }
}
