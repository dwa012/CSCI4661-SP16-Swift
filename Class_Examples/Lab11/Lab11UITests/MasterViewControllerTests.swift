//
//  MasterViewControllerTests.swift
//  Lab11
//
//  Created by Daniel Ward on 4/25/16.
//  Copyright © 2016 CSCI4669. All rights reserved.
//

import XCTest
import Fakery
import SuperRecord

@testable import Lab11
class MasterViewControllerTests: XCTestCase {
    
    let faker = Faker()
    
        
    override func setUp() {
        super.setUp()
        let app = XCUIApplication()
    
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        setupSnapshot(app)
        
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddButtonExists() {
        // 3 : Check that the Add Contact button exists
    }
    
    func testAddButtonShowsForm() {
        // 4 : Check that the form is shown and the fields can be entered    }
    
    func testEnterFormData() {
        // 5 : Check that the form data was saved properly    }

}
