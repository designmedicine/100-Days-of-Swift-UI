//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Natasha Godwin on 6/20/21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var genre: String?
    @NSManaged public var albums: NSSet?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
    
    var wrappedGenre: String {
        genre ?? "Unknown"
    }
    
    public var albumsArray: [Album] {
        let set = albums as? Set<Album> ?? []
        return set.sorted {
            $0.year < $1.year
        }
    }

}

extension Singer : Identifiable {

}
