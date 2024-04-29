//
//  DateExtension.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation

public extension Date {
    var iso8601String : String {
        Formatter.iso8601Inter.string(from: self)
    }
}
