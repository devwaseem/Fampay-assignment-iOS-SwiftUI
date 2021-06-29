//
//  CDBigDisplayCardReminder+CoreDataProperties.swift
//  
//
//  Created by Waseem Akram on 29/06/21.
//
//

import Foundation
import CoreData


extension CDBigDisplayCardIgnoringList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBigDisplayCardIgnoringList> {
        return NSFetchRequest<CDBigDisplayCardIgnoringList>(entityName: "CDBigDisplayCardIgnoringList")
    }

    @NSManaged public var id: Int64
    
    func set(id: Int) {
        self.id = Int64(id)
    }

}

