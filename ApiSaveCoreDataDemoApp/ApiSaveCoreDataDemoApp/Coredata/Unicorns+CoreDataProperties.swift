//
//  Unicorns+CoreDataProperties.swift
//  ApiSaveCoreDataDemoApp
//
//  Created by CV on 6/10/23.
//
//

import Foundation
import CoreData


extension Unicorns {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Unicorns> {
        return NSFetchRequest<Unicorns>(entityName: "Unicorns")
    }

    @NSManaged public var age: String?
    @NSManaged public var colour: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension Unicorns : Identifiable {

}
