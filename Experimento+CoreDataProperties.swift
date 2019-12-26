//
//  Experimento+CoreDataProperties.swift
//  amazoonia
//
//  Created by Daniel Martinez on 17/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//
//

import Foundation
import CoreData


extension Experimento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Experimento> {
        return NSFetchRequest<Experimento>(entityName: "Experimento")
    }

    @NSManaged public var aquatic: Bool
    @NSManaged public var backbone: Bool
    @NSManaged public var date: Date
    @NSManaged public var eggs: Bool
    @NSManaged public var legs: Int16
    @NSManaged public var milk: Bool
    @NSManaged public var name: String
    @NSManaged public var mark: String
    @NSManaged public var dateString: String
    @NSManaged public var photo: NSData
    @NSManaged public var type: String
    @NSManaged public var alumno: Alumno

}
