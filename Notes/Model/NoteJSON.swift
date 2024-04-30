//
//  Note.swift
//  Notes
//
//  Created by Rodrigo on 29/04/24.
//

import Foundation

struct NoteJSON : Codable{
    var id : UUID
    var title : String
    var body: String
    var date: Date
    var fontColor: String
    var fontSize: Int
}
