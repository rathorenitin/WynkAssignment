//
//  SearchImageCVCell.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class SearchImageCVCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    //================
    @IBOutlet weak var searchImageView: UIImageView!
    
    // MARK: Properties
    //=================
    var model: Hit? {
        didSet {
            configureData()
        }
    }
    
    //MARK:- View Life Cycle
    //======================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        searchImageView.image = #imageLiteral(resourceName: "ic_placeholder")
    }
    
    
    private func configureData() {
        guard let object = self.model else {return}
        searchImageView.setImage(url: object.previewURL, placeholderImage: #imageLiteral(resourceName: "ic_placeholder"))
    }
}

