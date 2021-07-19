//
//  DataViewModel.swift
//  Map (iOS)
//
//  Created by Alice Zolotareva on 16.07.2021.
//

import Foundation
import CoreData

class UserPlaceViewModel: ObservableObject{
    
    var name: String = ""
    var placeForSave: CLPlacemark
    @Published var places: [UPViewModel] = []
    
    init(placeForSave: CLPlacemark){
        self.placeForSave = placeForSave
    }
    
    func getAllTasks() {
        places = CoreDataManager.shared.getAllUserPlaces().map(UPViewModel.init)
    }
    
    func delete(_ place: UPViewModel){
        let existingTask = CoreDataManager.shared.getUserPlaceById(id: place.id)
        if let existingTask = existingTask{
            CoreDataManager.shared.deleteUserPlace(place: existingTask)
        }
    }
    
    func save(){
        
        let place = UserPlace(context: CoreDataManager.shared.viewContext)
        place.name = name
        
        CoreDataManager.shared.save()
    }
    
}

struct UPViewModel {
    
    let place: UserPlace
    
    var id: NSManagedObjectID {
        return place.objectID
    }
    var name: String {
        return place.name ?? ""
    }
}
