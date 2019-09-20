//
//  User+CoreDataProperties.swift
//  
//
//  Created by Rafeeq Ebrahim on 03/12/18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var city: String?
    @NSManaged public var location: String?
    @NSManaged public var address: String?
    @NSManaged public var sex: Int16

}
