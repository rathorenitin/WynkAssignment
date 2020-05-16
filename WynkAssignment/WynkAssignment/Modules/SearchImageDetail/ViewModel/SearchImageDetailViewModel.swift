//
//  SearchImageDetailViewModel.swift
//  WynkAssignment
//
//  Created by Admin on 17/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

//MARK:- SearchImage ViewModel
//=============================
class SearchImageDetailViewModel: NSObject {
    
    // MARK: Properties
    //=================
    var imageList = [Hit]()
    
    // MARK: Private Properties
    //=================
    
    
    // MARK: Initializers
    //====================
    override init() {
    }
    
    // MARK: Function Implementation
    //=======================================
    
    /*
     return collectionview no of rows
     */
    func numberOfRowsForCV() -> Int{
        return imageList.count
    }
    
    /*
     return model for passed index
     */
    func getHitModel(_ index : Int)  -> Hit? {
        if imageList.indices.contains(index) {
            return imageList[index]
        }
        
        return nil
    }
    
    /*
     return height for passed index
     */
    func getImageHeight(_ index : Int)  -> Int {
        if imageList.indices.contains(index) {
            return imageList[index].previewHeight
        }
        
        return 0
    }
    
    
}




