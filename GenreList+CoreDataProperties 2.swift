//
//  GenreList+CoreDataProperties.swift
//  NetflixClone
//
//  Created by  Robin George  on 02/12/21.
//
//

import Foundation
import CoreData


extension GenreList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreList> {
        return NSFetchRequest<GenreList>(entityName: "GenreList")
    }

    @NSManaged public var id: NSObject?
    @NSManaged public var name: String?

}

extension GenreList : Identifiable {

}
