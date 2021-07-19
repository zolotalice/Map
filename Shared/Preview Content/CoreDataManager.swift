//
//  CoreDataManager.swift
//  Map (iOS)
//
//  Created by Alice Zolotareva on 16.07.2021.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let persistentContainer: NSPersistentContainer

    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func getUserPlaceById(id: NSManagedObjectID) -> UserPlace? {
        
        do{
         return try viewContext.existingObject(with: id) as? UserPlace
        }catch{
            return nil
        }
    }
    
    func deleteUserPlace(place: UserPlace) {
        
        viewContext.delete(place)
        save()
        
    }
    
    func getAllUserPlaces() -> [UserPlace] {
        
        let request: NSFetchRequest<UserPlace> = UserPlace.fetchRequest()
        
        do{
            return try viewContext.fetch(request)
        }catch{
            return []
        }
        
    }
    
    func save(){
        do{
         try viewContext.save()
        } catch{
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
}

