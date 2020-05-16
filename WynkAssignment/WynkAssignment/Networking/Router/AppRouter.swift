//
//  AppRouter.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

enum AppRouter {
    
    case getSeacrchList(String,Int)
    
    
    var baseURL: String {
        
        return "https://pixabay.com/api/"
    }
    
    var getURL: URL {
        
        switch self {
        case .getSeacrchList(let searchText,let pageNumber):
            let params = "?key=" + "16545266-b1312151d77a63eceaa5bca42"  + "&q="  +  "\(searchText)"  +  "&page="  +  "\(pageNumber)" + "&image_type=photo"
            return URL(string: "\(baseURL + params)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        }
    }
    
    var getHTTPMethod: String {
        
        switch self {
        case .getSeacrchList:
            return "GET"
        }
    }
    
}
