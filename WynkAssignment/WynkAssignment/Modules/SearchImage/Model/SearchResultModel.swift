//
//  SearchResultModel.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import Foundation

struct SearchResultModel: Codable {
    let total, totalHits: Int
    let hits: [Hit]
}
