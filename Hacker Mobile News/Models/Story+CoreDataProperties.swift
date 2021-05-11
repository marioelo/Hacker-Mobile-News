//
//  Story+CoreDataProperties.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 10-05-21.
//
//

import Foundation
import CoreData


extension Story {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Story> {
        return NSFetchRequest<Story>(entityName: "Story")
    }

    @NSManaged public var author: String
    @NSManaged public var createdAt: Date
    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var isRemoved: Bool

}

extension Story : Identifiable {

}
