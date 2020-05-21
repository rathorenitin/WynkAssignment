//
//  SearchResultModelTestCase.swift
//  WynkAssignmentTests
//
//  Created by Admin on 22/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import XCTest
@testable import WynkAssignment

class SearchResultModelTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchResultModel() {
        
        if let path = Bundle.main.path(forResource:"document", ofType:"json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let result = try JSONDecoder().decode(SearchResultModel.self, from: data)
                
                if result != nil {
                    XCTAssert(true, "Expected sucess when there is data")
                } else {
                    XCTAssert(false, "Expected failure when no data")
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
    }
}


