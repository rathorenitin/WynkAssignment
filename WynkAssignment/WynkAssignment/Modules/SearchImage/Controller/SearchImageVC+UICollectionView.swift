//
//  SearchImageVC+UICollectionView.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

// MARK: Collection View DataSources
extension SearchImageVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.viewModel.numberOfRowsForCV()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: SearchImageCVCell.self, indexPath: indexPath)
        cell.model = self.viewModel.getHitModel(indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueFooterView(with: SearchImageCVFooterView.self, indexPath: indexPath)
        
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        // Hitting api for pagination
        if view.isKind(of: SearchImageCVFooterView.self) {
            self.viewModel.fetchNextImageList()
        }
    }
}

// MARK: Collection View Delegates
extension SearchImageVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.item
        _ = NavigationRouter.shared.navigateToSearchImageDetailsViewController(listData: self.viewModel.imageList, index: self.index, delegate: self)
        
    }
    
    
}

// MARK: CollectionView Delegate FlowLayout
extension SearchImageVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return self.viewModel.showPaginationLoader ? CGSize(width: collectionView.frame.width, height: 60) : CGSize.zero
    }
}


/*
 commented this code dues to some issue n animation
 // MARK: UIViewController Transitioning Delegate Methods
 extension SearchImageVC: UIViewControllerTransitioningDelegate {
 
 func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
 return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
 }
 
 func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
 
 guard let cell = self.searchImageCV.cellForItem(at: IndexPath(item: index, section: 0)) else { return nil }
 let currentFrame = self.returnCellFrameWithViewController(cell: cell)
 
 return GalleryPresentingAnimator(pageIndex: index, originFrame: currentFrame)
 }
 
 func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
 guard let returnCellFrame = self.searchImageCV.cellForItem(at: IndexPath(item: index, section: 0)) else { return nil }
 let cardFrame = returnCellFrameWithViewController(cell:returnCellFrame)
 return GalleryImageDismissAnimator(pageIndex: index, finalFrame: cardFrame)
 }
 
 
 func returnCellFrameWithViewController(cell: UICollectionViewCell)-> CGRect{
 let currentCellFrame = cell.layer.presentation()!.frame
 let cardFrame = cell.superview!.convert(currentCellFrame, to: nil)
 return cardFrame
 }
 
 }
 */

