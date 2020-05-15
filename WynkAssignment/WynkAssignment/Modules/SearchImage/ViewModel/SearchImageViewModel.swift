//
//  SearchImageViewModel.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

class SearchImageViewModel {
    
    var contactDidChanges: ((Bool, Bool) -> Void)?
    var errorHandler: ((String) -> Void)?
    var titleDidChanges: ((String) -> Void)?
    let networkService: NetworkServiceProtocol = NetworkService()
//    private var factList = [FactModel]() {
//        didSet {
//            self.contactDidChanges?(true, false)
//        }
//    }
    
    init() {
//        factList = [FactModel]()
    }
    
//    func fetchFactsList() {
//        var serviceType = AppRouter.getSeacrchList
//        serviceType.getRequestParameter["search"] = "" as NSObject
//        networkService.webRequest(.getSeacrchList, { [weak self] response in
//
//            guard let strongSelf = self else {return}
//
//            let utf8Data = String(decoding: response, as: UTF8.self).data(using: .utf8)
//            let feedModel = try? JSONDecoder().decode(FeedsModel.self, from: utf8Data ?? response)
//            strongSelf.title = feedModel?.title
//            if let facts = feedModel?.rows {
//                strongSelf.factList = facts
//            } else {
//                print("Unable to decode json for facts list.")
//                strongSelf.errorHandler?("Unable to decode json for facts list.")
//            }
//        }) { [weak self] error in
//
//            guard let strongSelf = self else {return}
//
//            print("Error : \(error)")
//            strongSelf.errorHandler?(error.localizedDescription)
//        }
//    }

    
}
