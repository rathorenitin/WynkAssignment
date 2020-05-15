//
//  UICollectionView+Extension.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    enum WayToUpdate {
        
        case None
        case ReloadData
        case Insert([IndexPath])
        case ReloadItems([IndexPath])
        case ReloadSections(IndexSet)
        
        
        func performWithCollectionView(collectionView: UICollectionView) {
            
            switch self {
                
            case .None:
                break
                
            case .ReloadData:
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                
            case .Insert(let indexPaths):
                DispatchQueue.main.async {
                    collectionView.insertItems(at: indexPaths)
                }
            case .ReloadItems(let indexPaths):
                DispatchQueue.main.async {
                    collectionView.reloadItems(at: indexPaths)
                }
                
            case .ReloadSections(let indexSet):
                DispatchQueue.main.async {
                    collectionView.reloadSections(indexSet)
                }
                
            }
        }
    }
    
    func registerCell(with identifier: UICollectionViewCell.Type) {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellWithReuseIdentifier: "\(identifier.self)")
    }
    
    
    func dequeueCell <T: UICollectionViewCell> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
}

