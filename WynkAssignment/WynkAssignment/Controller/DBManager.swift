//
//  DBManager.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

class DBManager {
    
    static let shared = DBManager()
    private init() {
        loadData()
    }
    
    var recentSeacrhList: [RecentSearchModel] = []
    
    //MARK:- extension for private methods
    //====================================
    private func saveData() {
        do{
            
            let archive = try NSKeyedArchiver.archivedData(withRootObject: DBManager.shared.recentSeacrhList, requiringSecureCoding: false)
            UserDefaults.standard.set(archive, forKey: AppUserDefaults.Key.searchList.rawValue)
            
        }catch{
            print("!!!!!Error saving Game data == \(error)")
        }
        
        
    }
    
    private func loadData() {
        
        if let data = UserDefaults.standard.data(forKey: AppUserDefaults.Key.searchList.rawValue) {
            let result =  try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [RecentSearchModel]
            self.recentSeacrhList = result ?? []
        }
    }
    
    func saveSearchItem(item: RecentSearchModel) {
        if let indexItem = DBManager.shared.recentSeacrhList.firstIndex(where: { (searchItem) -> Bool in
            return  item.searchText.lowercased() == searchItem.searchText.lowercased()
        }) {
            print("index of item: \(indexItem)")
            self.recentSeacrhList.remove(at: indexItem)
            self.recentSeacrhList.insert(item, at: 0)
        } else {
            self.recentSeacrhList.insert(item, at: 0)
            
            if self.recentSeacrhList.count >= 10 {
                _ = self.recentSeacrhList.dropLast()
            }
        }
        
        self.recentSeacrhList.sort { (object1, object2) -> Bool in
            return object1.searchDate > object2.searchDate
        }
        
        self.saveData()
    }
    
    
    
    func clearDB() {
        self.recentSeacrhList.removeAll()
        self.saveData()
    }
    
}
