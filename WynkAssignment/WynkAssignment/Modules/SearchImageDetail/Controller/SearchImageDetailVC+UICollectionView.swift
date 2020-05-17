//
//  SearchImageDetailVC+UICollectionView.swift
//  WynkAssignment
//
//  Created by Admin on 17/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

// MARK: UICollectionViewDataSource Methods
extension SearchImageDetailVC: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsForCV()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: SearchImageDetailCVCell.self, indexPath: indexPath)
        cell.configureData(with: self.viewModel.getHitModel(indexPath.row))
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SearchImageDetailCVCell", for: indexPath) as! SearchImageDetailCVCell
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            cell.configureData(with: self.viewModel.getHitModel(0))
        case UICollectionView.elementKindSectionHeader:
            cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchImageDetailCVCell", for: indexPath) as! SearchImageDetailCVCell
            if isViewFirstAppearing {
                cell.configureData(with: self.viewModel.getHitModel(0))
            } else {
                cell.configureData(with: self.viewModel.getHitModel(numberOfImages - 1))
            }
        default:
            assertionFailure("Unexpected element kind")
        }
        
        return cell
    }
    
    
    @objc public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard isRevolvingCarouselEnabled else { return CGSize.zero }
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard isRevolvingCarouselEnabled else { return CGSize.zero }
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}


// MARK: UICollectionViewDelegate Methods
extension SearchImageDetailVC: UICollectionViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animateImageTransition = true
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animateImageTransition = false
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SearchImageDetailCVCell {
            cell.configureForNewImage(animated: animateImageTransition)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if let cell = view as? SearchImageDetailCVCell {
            collectionView.layoutIfNeeded()
            cell.configureForNewImage(animated: animateImageTransition)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionFooter).isEmpty && !deviceInRotation || (currentPage == numberOfImages && !deviceInRotation) {
            currentPage = 0
        }
        if !collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).isEmpty && !deviceInRotation || (currentPage == -1 && !deviceInRotation) {
            currentPage = numberOfImages - 1
        }
        deviceInRotation = false
    }
}

