//
//  Alumno+CoreDataProperties.swift
//  amazoonia
//
//  Created by Daniel Martinez on 17/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//
//

import Foundation
import CoreData


extension Alumno {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alumno> {
        return NSFetchRequest<Alumno>(entityName: "Alumno")
    }

    @NSManaged public var name: String
    @NSManaged public var numExp: Int16
    @NSManaged public var password: String
    @NSManaged public var photo: NSData
    @NSManaged public var user: String
    @NSManaged public var experimentos: NSSet
    @NSManaged public var profesor: Profesor

}

// MARK: Generated accessors for experimentos
extension Alumno {

    @objc(addExperimentosObject:)
    @NSManaged public func addToExperimentos(_ value: Experimento)

    @objc(removeExperimentosObject:)
    @NSManaged public func removeFromExperimentos(_ value: Experimento)

    @objc(addExperimentos:)
    @NSManaged public func addToExperimentos(_ values: NSSet)

    @objc(removeExperimentos:)
    @NSManaged public func removeFromExperimentos(_ values: NSSet)

}
