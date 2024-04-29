//
//  Note+CoreDataProperties.swift
//  Notes
//
//  Created by Rodrigo on 28/04/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var fontColor: String?
    @NSManaged public var fontSize: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
