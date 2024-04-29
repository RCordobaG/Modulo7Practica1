//
//  DateTimeFormatter.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//

import Foundation

public extension Formatter {
    static let iso8601MX: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "es_MX")
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        formatter.dateFormat = "dd/MM/yyyy' 'HH:mm:ss"
        //formatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ss.SSSZZZZZ"
        return formatter
    }()
    
    static let iso8601Inter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = .autoupdatingCurrent
        formatter.timeZone = .autoupdatingCurrent
        formatter.dateFormat = "dd/MM/yyyy' 'HH:mm:ss"
        
        return formatter
    }()
}
