//
//  BigDisplayCardReminder.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 29/06/21.
//

import Foundation
import CoreData
import Combine

class BigDisplayCardIgnoringListRepository {
    
    enum BigDisplayCardReminderRepositoryError: Error {
        case saveFailed
    }
    
    let context = PersistenceController.shared.container.viewContext
    
    func getAll() -> Future<[CDBigDisplayCardIgnoringList], Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            do {
                let results: [CDBigDisplayCardIgnoringList] = try self.context.fetch(CDBigDisplayCardIgnoringList.fetchRequest())
                return promise(.success(results))
            } catch let error {
                return promise(.failure(error))
            }
        }
    }
    
    func isCardExisits(id: Int) -> Future<Bool, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            do {
                
                let fetchRequest: NSFetchRequest<CDBigDisplayCardIgnoringList> = CDBigDisplayCardIgnoringList.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", Int64(id))
                let results = try self.context.fetch(fetchRequest)
                if results.first != nil {
                    return promise(.success(true))
                }
            } catch let error {
                return promise(.failure(error))
            }
            return promise(.success(false))
        }
    }
    
    func insert(id: Int) -> Future<Void, Error> {
        Future { [weak self] promise in
            guard let self = self else { return }
            let reminder = CDBigDisplayCardIgnoringList(context: self.context)
            reminder.set(id: id)
            do {
                if self.context.hasChanges {
                    try self.context.save()
                    return promise(.success(()))
                }
            }catch let error {
                debugPrint(error)
                return promise(.failure(error))
            }
            
            return promise(.failure(BigDisplayCardReminderRepositoryError.saveFailed))
        }
        
    }
    
    
}
