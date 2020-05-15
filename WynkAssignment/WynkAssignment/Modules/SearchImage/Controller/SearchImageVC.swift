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
    var sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var collectionViewSize : CGSize {
        get {
            let minimumInterItemSpacing: CGFloat = 10
            let side = (searchImageCV.frame.width - sectionInsets.left - sectionInsets.right - CGFloat(numberOfColumns - 1)*minimumInterItemSpacing - 0.002) / CGFloat(numberOfColumns)
            
            return CGSize.init(width: side, height: side)
        }
    }
    
    //MARK:- View Life Cycle
    //======================
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
    
    
    override func bindController() {
        //viewModel.delegate = self
    }
}

// MARK: Extension for private methods
//=====================================
extension SearchImageVC {
    
    private func initialSetup() {
        registerXibs()
        searchImageCV.dataSource = self
        searchImageCV.delegate = self
//        searchImageTV.dataSource = self
//        searchImageTV.delegate = self
        setupNavBar()
    }
    
    private func registerXibs() {
        searchImageCV.registerCell(with: SearchImageCVCell.self)
        //searchImageCV.registerFooterView(with: ImageCollectionViewFooterView.self)
        
        searchImageTV.registerCell(with: SearchImageTVCell.self)
        
    }
    
    private func setupNavBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Images..."
        navigationItem.titleView = searchBar
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icMore"), style: .plain, target: self, action: #selector(rightNavBarBtnTapped))
    }
}

//MARK:- Extension for UISearchBar Delegate
//=========================================
extension SearchImageVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            //self.viewController.searchFlickrImageForText(searchText: searchText)
        }
    }
    
}
