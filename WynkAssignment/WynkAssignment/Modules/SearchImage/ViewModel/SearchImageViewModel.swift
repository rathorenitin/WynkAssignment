//
//  SearchImageViewModel.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

//MARK:- SearchImage ViewModel
//=============================
class SearchImageViewModel: NSObject {
    
    // MARK: Properties
    //=================
    var searchedTextArrayDataDidChanges: ((Bool) -> Void)?
    var imageDataDidChanges: ((Bool, Bool) -> Void)?
    var errorHandler: ((String) -> Void)?
    let networkService: NetworkServiceProtocol = NetworkService()
    var showPaginationLoader: Bool {
        return (self.page > 0 && !self.searchText.isEmpty)
    }
    var imageList = [Hit]() {
        didSet {
            self.imageDataDidChanges?(true, false)
        }
    }
    
    // MARK: Private Properties
    //=================
    private var page = 0
    private var isApiRequestCompleted = true
    
    private var searchedTermsList = [RecentSearchModel]() {
        didSet {
            self.searchedTextArrayDataDidChanges?(true)
        }
    }
    private var searchText = ""
    
    
    // MARK: Initializers
    //====================
    override init() {
        imageList = [Hit]()
        searchedTermsList = DBManager.shared.recentSeacrhList
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
    
    /*
     return tableView no of rows
     */
    func numberOfRowsForTV() -> Int{
        return searchedTermsList.count
    }
    
    /*
     return searched text for passed index
     */
    func getSearchedTerm(_ index : Int)  -> RecentSearchModel? {
        if searchedTermsList.indices.contains(index) {
            return searchedTermsList[index]
        }
        
        return nil
    }
    
    /*
     return tableView no of rows
     */
    func canShowSearchView() -> Bool{
        return (!searchedTermsList.isEmpty && imageList.isEmpty)
    }
    
    /*
     reset the data
     */
    func resetData() {
        self.page = 1
        self.isApiRequestCompleted = true
        self.imageList.removeAll()
        self.searchText = ""
    }
    
    /*
     searching is performed for passed text and default property are rested
     */
    func searchImageWithText(_ searchText: String){
        resetData()
        self.searchText = searchText.byRemovingLeadingTrailingWhiteSpaces
        guard !self.searchText.isEmpty else {return}
        self.hitImageListApi(self.searchText, page: self.page)
    }
    
    /*
     api is called for next page
     */
    func fetchNextImageList() {
        hitImageListApi(self.searchText, page: self.page)
    }
}

//MARK:- Extension for api call
//=============================
extension SearchImageViewModel {
    
    /*
     api is called, check for page is greater then equal 1, api execuation is completed, search text is not empty
     */
    @objc private func hitImageListApi(_ searchText: String, page: Int) {
        
        guard page >= 1, self.isApiRequestCompleted, !searchText.isEmpty else {return}
        
        self.isApiRequestCompleted = false
        networkService.webRequest(.getSeacrchList(searchText, page), { [weak self] response in
            guard let strongSelf = self else {return}
            print(String(decoding: response, as: UTF8.self))
            let utf8Data = String(decoding: response, as: UTF8.self).data(using: .utf8)
            if let feedModel = try? JSONDecoder().decode(SearchResultModel.self, from: utf8Data ?? response) {
                if strongSelf.searchText.isEmpty {
                    strongSelf.imageList.removeAll()
                    strongSelf.page = 0
                } else {
                    strongSelf.imageList += feedModel.hits
                    strongSelf.page = feedModel.hits.isEmpty ? 0 :  strongSelf.page + 1
                }
                if !feedModel.hits.isEmpty {
                    DBManager.shared.saveSearchItem(item: RecentSearchModel(name: searchText))
                    strongSelf.searchedTermsList = DBManager.shared.recentSeacrhList
                } else {
                    if page == 1 {
                        strongSelf.errorHandler?("No image found for \(searchText)")
                    }
                }
                
            } else {
                print("Unable to decode json for SearchResultModel list.")
                strongSelf.errorHandler?("Unable to decode json for SearchResultModel list.")
                strongSelf.page = 0
            }
            strongSelf.isApiRequestCompleted = true
        }) { [weak self] error in
            
            guard let strongSelf = self else {return}
            
            print("Error : \(error)")
            strongSelf.isApiRequestCompleted = true
            strongSelf.errorHandler?(error.localizedDescription)
        }
    }
}


