//
//  SearchImageVC.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class SearchImageVC: BaseVC {
    
    // MARK: IBOutlets
    //================
    @IBOutlet weak var searchImageCV: UICollectionView!
    @IBOutlet weak var searchImageTV: UITableView!
    @IBOutlet weak var serachTVContainer: UIView!
    
    // MARK: Properties
    //=================
    private var searchBar = UISearchBar()
    let viewModel = SearchImageViewModel()
    var numberOfColumns = 2
    let minimumInterItemSpacing: CGFloat = 10
    var sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var collectionViewSize : CGSize {
        get {
            let totalSpace = sectionInsets.left
                + sectionInsets.right
                + (minimumInterItemSpacing * CGFloat(numberOfColumns - 1))
            let size = Int((searchImageCV.bounds.width - totalSpace) / CGFloat(numberOfColumns))
            return CGSize.init(width: size, height: size)
        }
    }
    var index: Int = 0
    
    //MARK:- View Life Cycle
    //======================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    //MARK:- @IBAction
    //================
    @objc  func rightNavBarBtnTapped(_ sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
        self.viewModel.resetData()
    }
}

// MARK: Extension for private methods
//=====================================
extension SearchImageVC {
    /*
     setup for implementing delegate and datasource for tableview and collectionview, searchbar and viewmodel observers
    */
    private func initialSetup() {
        registerXibs()
        searchImageCV.dataSource = self
        searchImageCV.delegate = self
        searchImageTV.dataSource = self
        searchImageTV.delegate = self
        setupNavBar()
        self.prepareViewModelObserver()
        serachTVContainer.isHidden = true
    }
    
    /*
    registering the xibs for collectionview and tableview
    */
    private func registerXibs() {
        // registering xibs for collectionview
        searchImageCV.registerCell(with: SearchImageCVCell.self)
        searchImageCV.registerFooterView(with: SearchImageCVFooterView.self)
        // registering xibs for tableview
        searchImageTV.registerCell(with: SearchImageTVCell.self)
        
    }
    /*
    adding search bar in navigation bar
    */
    private func setupNavBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Images..."
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(rightNavBarBtnTapped))
    }
}

//MARK:- Extension for UISearchBar Delegate
//=========================================
extension SearchImageVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForText(text: searchBar.text ?? "")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.viewModel.resetData()
        updateViewForSearch(searchText: searchBar.text ?? "")
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        serachTVContainer.isHidden = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateViewForSearch(searchText: searchText)
    }
    
    /*
    resigning the searchbar and hitting the api for result
    */
    func searchForText(text: String) {
        searchBar.resignFirstResponder()
        searchBar.text = text
        self.viewModel.searchImageWithText(text)
    }
}

//MARK:- API Call action and search result obsevers
extension SearchImageVC {
    
    /*
     oembserver for updating collection on success of api result, updating tableview when searched item array is updated and observer for error recevied from api
     */
    func prepareViewModelObserver() {
        
        self.viewModel.imageDataDidChanges = { [weak self] (finished, error) in
            guard let strongSelf = self else { return }
            if !error {
                DispatchQueue.main.async {
                    strongSelf.searchImageCV.reloadData()
                }
            }
        }
        
        self.viewModel.errorHandler = { [weak self] (errorMessage) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.showAlert(with: "ERROR", message: errorMessage)
            }
        }
        
        self.viewModel.searchedTextArrayDataDidChanges = { [weak self] (resultChanged) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.searchImageTV.reloadData()
            }
        }
        
    }
    
    /*
     filtering the searched term for searched text and check if there is any result the show searchview
     */
    func updateViewForSearch(searchText: String) {
        self.viewModel.filterSuggestion(searchText)
        serachTVContainer.isHidden = !self.viewModel.canShowSearchView()
    }
    
}
