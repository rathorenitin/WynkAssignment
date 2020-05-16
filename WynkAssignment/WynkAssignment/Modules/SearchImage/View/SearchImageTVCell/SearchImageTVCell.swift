//
//  SearchImageTVCell.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

class SearchImageTVCell: UITableViewCell {

    // MARK: IBOutlets
    //================
    @IBOutlet weak var searchedTextLabel: UILabel!
    
    // MARK: Properties
    //=================
    var searchedTerm: RecentSearchModel? {
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func initialSetup(){
        searchedTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        searchedTextLabel.textColor = UIColor.gray
    }
    
    private func configureData() {
        guard let object = self.searchedTerm else {return}
        searchedTextLabel.text = object.searchText
    }
}
