//
//  ApiTestCase.swift
//  WynkAssignment
//
//  Created by Admin on 22/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import XCTest
@testable import WynkAssignment

class ApiTestCase: XCTestCase {
    
    var viewModel: SearchImageViewModel!
    
    
    override func setUp() {
        super.setUp()
        self.viewModel = SearchImageViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        self.viewModel = nil
    }
    
    func testSeacrhImage() {
        
        self.viewModel.imageDataDidChanges = { (success, error) in
            if error {
                XCTAssert(false, "Fetching images from server fail")
            } else {
                XCTAssert(true, "Fetching images from server pass")
                
            }
        }
        self.viewModel.searchImageWithText("apple")
        
    }
    
    func testPerformanceOfSearchImage() {
        var sucesss: Bool?
        let expection = expectation(description:"wait for api to return")
        self.viewModel.imageDataDidChanges = { (success, error) in
            if error {
                XCTAssert(false, "Fetching images from server fail")
            } else {
                XCTAssert(true, "Fetching images from server pass")
                
            }
            sucesss = true
            expection.fulfill()
        }
        self.viewModel.searchImageWithText("apple")
        waitForExpectations(timeout:5) { (eroor) in
            XCTAssertNotNil(sucesss)
        }
    }
}
