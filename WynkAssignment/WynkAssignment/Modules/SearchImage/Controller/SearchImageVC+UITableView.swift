//
//  SearchImageVC+UITableView.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

// MARK: TableView Delegate
// MARK: - TableView DataSource
extension SearchImageVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsForTV()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(with: SearchImageTVCell.self)
        cell.searchedTerm = self.viewModel.getSearchedTerm(indexPath.row)
        return cell
        
    }
        
}

// MARK: - TableView Delegate
extension SearchImageVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = self.viewModel.getSearchedTerm(indexPath.row) {
            searchForText(text: object.searchText)
        }
    }
}


