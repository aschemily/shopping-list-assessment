//
//  ItemController.swift
//  Shopping List Assessment
//
//  Created by Emily Asch on 2/11/22.
//

import Foundation

class ItemController{
    
    //MARK: shared instance
    static let shared = ItemController()
    
    //MARK: Source of truth
    var items: [Item] = []
    
    

    //MARK: CRUD
    
    //create
    func createItem(name: String){
        let newItem = Item(name: name)
        print("new item should?", newItem)
        items.append(newItem)
        saveToPersistentStorage()
    }
    
    //delete
    
    func deleteItem(item: Item){
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
        saveToPersistentStorage()
    }
    
    //toggle
    func togglePressed(item: Item){
        item.isComplete = !item.isComplete
        saveToPersistentStorage()
    }
    
    //MARK: Persistence methods
    
    func fileURL()-> URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectorysURL = urls[0].appendingPathComponent("Item.json")
        
        return documentDirectorysURL
    }
    
    func saveToPersistentStorage(){
        do{
            let data = try JSONEncoder().encode(items)
            try data.write(to:fileURL())
        }catch{
            print("🤞save errory", error)
        }
    }
    
    func loadFromPersistentStorage(){
        do{
           let data = try Data(contentsOf: fileURL())
            items = try JSONDecoder().decode([Item].self, from: data)
        }catch{
            print("😬load from storage", error)
        }
    }
    
    
}
