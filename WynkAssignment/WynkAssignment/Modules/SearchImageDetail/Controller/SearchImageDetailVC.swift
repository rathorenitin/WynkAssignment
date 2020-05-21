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
    
    //MARK:- @IBAction
    //================
    /*
     pangesture selector handling the zoom and dismiss of viewcontroller
     */
    @objc private func wasDragged(_ gesture: PanDirectionGestureRecognizer) {
        
        guard let image = gesture.view, isSwipeToDismissEnabled else { return }
        
        let translation = gesture.translation(in: self.view)
        image.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY + translation.y)
        
        let yFromCenter = image.center.y - self.view.bounds.midY
        
        let alpha = 1 - abs(yFromCenter / self.view.bounds.midY)
        self.view.backgroundColor = backgroundColor.withAlphaComponent(alpha)
        
        if gesture.state == UIGestureRecognizer.State.ended {
            
            var swipeDistance: CGFloat = 0
            let swipeBuffer: CGFloat = 50
            var animateImageAway = false
            
            if yFromCenter > -swipeBuffer && yFromCenter < swipeBuffer {
                // reset everything
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.backgroundColor = self.backgroundColor.withAlphaComponent(1.0)
                    image.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                })
            } else if yFromCenter < -swipeBuffer {
                swipeDistance = 0
                animateImageAway = true
            } else {
                swipeDistance = self.view.bounds.height
                animateImageAway = true
            }
            
            if animateImageAway {
                if self.modalPresentationStyle == .custom {
                    NavigationRouter.shared.dismissViewController()
                    return
                }
                
                UIView.animate(withDuration: 0.35, animations: {
                    self.view.alpha = 0
                    image.center = CGPoint(x: self.view.bounds.midX, y: swipeDistance)
                }, completion: { (complete) in
                    NavigationRouter.shared.dismissViewController()
                })
            }
            
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
        setupGestureRecognizers()
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
    /*
     pangesture is added for zooming and dismissing the controller
     */
    private func setupGestureRecognizers() {
        
        let panGesture = PanDirectionGestureRecognizer(direction: CustomPanDirection.vertical, target: self, action: #selector(wasDragged(_:)))
        searchImageDetailCV.addGestureRecognizer(panGesture)
        searchImageDetailCV.isUserInteractionEnabled = true
        
    }
    
}


// MARK: Extension for GestureRecognizer Delegate
//================================================
extension SearchImageDetailVC: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return otherGestureRecognizer is UITapGestureRecognizer &&
            gestureRecognizer is UITapGestureRecognizer &&
            otherGestureRecognizer.view is SearchImageDetailCVCell &&
            gestureRecognizer.view == searchImageDetailCV
    }
}
