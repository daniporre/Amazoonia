//
//  Profesor+CoreDataProperties.swift
//  amazoonia
//
//  Created by Daniel Martinez on 17/12/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Profesor {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Profesor> {
        return NSFetchRequest<Profesor>(entityName: "Profesor")
    }

    @NSManaged public var name: String!
    @NSManaged public var password: String!
    @NSManaged public var photo: UIImage?
    @NSManaged public var user: String!
    @NSManaged public var listaAlumnos: NSSet?

}

// MARK: Generated accessors for listaAlumnos
extension Profesor {

    @objc(addListaAlumnosObject:)
    @NSManaged public func addToListaAlumnos(_ value: Alumno)

    @objc(removeListaAlumnosObject:)
    @NSManaged public func removeFromListaAlumnos(_ value: Alumno)
//
//    @objc(addListaAlumnos:)
//    @NSManaged public func addToListaAlumnos(_ values: NSSet)
//
//    @objc(removeListaAlumnos:)
//    @NSManaged public func removeFromListaAlumnos(_ values: NSSet)

}
