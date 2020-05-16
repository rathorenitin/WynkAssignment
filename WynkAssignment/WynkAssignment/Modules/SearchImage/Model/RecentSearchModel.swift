//
//  RecentSearchModel.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

class RecentSearchModel: NSObject, NSCoding {
    
    /*
     safe way of naming my decoder key(s)
     */
    struct Keys {
        static let searchText = "searchText"
        static let searchDate = "searchDate"
    }
        
    var searchText: String
    var searchDate: Date = Date()
    
    
    required init(name: String) {
        self.searchText = name
    }
    
    /*
     this decodes our objects; this isn't called explicitly, it will be called with NSKeyedArchiver
     */
    required init(coder decoder: NSCoder) {
        //this retrieves our saved name object and casts it as a string
        searchText = decoder.decodeObject(forKey: Keys.searchText) as? String ?? ""
        searchDate = decoder.decodeObject(forKey: Keys.searchDate) as? Date ?? Date()
    }
    /*
     this encodes our objects (saves them)
     */
    func encode(with coder: NSCoder) {
        //we are saving the name for the key "name"
        coder.encode(searchText, forKey: Keys.searchText)
        coder.encode(searchDate, forKey: Keys.searchDate)
    }
    
    
}
