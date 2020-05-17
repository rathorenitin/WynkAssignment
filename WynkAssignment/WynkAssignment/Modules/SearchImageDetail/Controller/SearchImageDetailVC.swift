//
//  SearchImageDetailVC.swift
//  WynkAssignment
//
//  Created by Admin on 17/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class SearchImageDetailVC: UIViewController {
    
    // MARK: IBOutlets
    //================
    @IBOutlet weak var searchImageDetailCV: UICollectionView!
    
    // MARK: Properties
    //=================
    let viewModel = SearchImageDetailViewModel()
    var animateImageTransition = false
    var isViewFirstAppearing = true
    var deviceInRotation = false
    
    public var backgroundColor: UIColor {
        get {
            return view.backgroundColor!
        }
        set(newBackgroundColor) {
            view.backgroundColor = newBackgroundColor
        }
    }
    public var numberOfImages: Int {
        return viewModel.numberOfRowsForCV()
    }
    
    public var currentPage: Int {
        set(page) {
            if page < numberOfImages {
                scrollToImage(withIndex: page, animated: false)
            } else {
                scrollToImage(withIndex: numberOfImages - 1, animated: false)
            }
        }
        get {
            if isRevolvingCarouselEnabled {
                pageBeforeRotation = Int(searchImageDetailCV.contentOffset.x / searchImageDetailCV.frame.size.width) - 1
                return Int(searchImageDetailCV.contentOffset.x / searchImageDetailCV.frame.size.width) - 1
            } else {
                pageBeforeRotation = Int(searchImageDetailCV.contentOffset.x / searchImageDetailCV.frame.size.width)
                return Int(searchImageDetailCV.contentOffset.x / searchImageDetailCV.frame.size.width)
            }
        }
    }
    
    
    public var hideStatusBar: Bool = true {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public var isSwipeToDismissEnabled: Bool = true
    public var isRevolvingCarouselEnabled: Bool = true
    
    private var pageBeforeRotation: Int = 0
    private var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    private var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private var needsLayout = true
    
    
    //MARK:- View Life Cycle
    //======================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        flowLayout.itemSize = view.bounds.size
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if needsLayout {
            let desiredIndexPath = IndexPath(item: pageBeforeRotation, section: 0)
            
            if pageBeforeRotation >= 0 {
                scrollToImage(withIndex: pageBeforeRotation, animated: false)
            }
            
            searchImageDetailCV.reloadItems(at: [desiredIndexPath])
            
            for cell in searchImageDetailCV.visibleCells {
                if let cell = cell as? SearchImageDetailCVCell {
                    cell.configureForNewImage(animated: false)
                }
            }
            
            needsLayout = false
        }
    }
    
    
}

// MARK: Extension for private methods
//=====================================
extension SearchImageDetailVC {
    /*
     setup for implementing delegate and datasource for tableview and collectionview and refrence of flowlayout
     */
    private func initialSetup() {
        registerXibs()
        if let layout = self.searchImageDetailCV?.collectionViewLayout as? UICollectionViewFlowLayout {
            self.flowLayout = layout
        }
        searchImageDetailCV.contentSize = CGSize(width: 1000.0, height: 1.0)
        searchImageDetailCV.dataSource = self
        searchImageDetailCV.delegate = self
    }
    
    /*
     registering the xibs for collectionview
     */
    private func registerXibs() {
        // registering xibs for collectionview
        searchImageDetailCV.register(SearchImageDetailCVCell.self, forCellWithReuseIdentifier: "SearchImageDetailCVCell")
        searchImageDetailCV.register(SearchImageDetailCVCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchImageDetailCVCell")
        searchImageDetailCV.register(SearchImageDetailCVCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchImageDetailCVCell")
    }
    /*
     scroll collectionview to passed index
     */
    private func scrollToImage(withIndex: Int, animated: Bool = false) {
        searchImageDetailCV.scrollToItem(at: IndexPath(item: withIndex, section: 0), at: .centeredHorizontally, animated: animated)
    }
}


