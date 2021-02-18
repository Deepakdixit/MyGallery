//
//  MyGalleryUITests.swift
//  MyGalleryUITests
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import XCTest

class MyGalleryUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: tests
    
    func testCollectionView() {
        let collectionView = app.collectionViews
        print(collectionView.cells.count)
        XCTAssertEqual(collectionView.cells.count, 8, "There should be 8 rows initially")
    }
    
    
    func testCollectionCellTap() {
        let firstCell = app.collectionViews.children(matching: .any).element(boundBy: 0)
        if firstCell.exists {
            firstCell.tap()
            print(app.state)
        }
        
//        app.navigationBars.buttons.element(boundBy: 0).tap()
//        app.navigationBars.buttons.element(boundBy: 0).press(forDuration: 0.05)
//        XCTAssertFalse(app.navigationBars["Photos"].exists)
    }
    
}
