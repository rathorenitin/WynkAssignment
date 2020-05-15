//
//  AppRouter.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

enum AppRouter {
    
    case getSeacrchList


    var baseURL: String {
        
        return "https://pixabay.com/"
    }
    
    var getURL: URL {
        
        switch self {
        case .getSeacrchList:
            return URL(string: "\(baseURL)")!
        }
    }
    
    var getRequestParameter: [String:AnyObject] {
        
        switch self {
        case .getSeacrchList:
            return ["image_type" : "photo" as AnyObject]
        }
    }
    
    var getHTTPMethod: String {
        
        switch self {
        case .getSeacrchList:
            return "GET"
        }
    }
    
}
