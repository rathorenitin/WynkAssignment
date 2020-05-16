//
//  UICollectionView+Extension.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell(with identifier: UICollectionViewCell.Type) {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellWithReuseIdentifier: "\(identifier.self)")
    }
    
    func dequeueCell <T: UICollectionViewCell> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
    
    func registerFooterView(with identifier: UICollectionReusableView.Type) {
       self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(identifier.self)")
    }
    
    func registerHeaderView(with identifier: UICollectionReusableView.Type) {
       self.register(UINib(nibName: "\(identifier.self)", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(identifier.self)")
    }
    
    func dequeueFooterView <T: UICollectionReusableView> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
    
    func dequeueHeaderView <T: UICollectionReusableView> (with identifier: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(identifier.self)", for: indexPath) as! T
    }
}

