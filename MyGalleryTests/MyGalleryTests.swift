//
//  MyGalleryTests.swift
//  MyGalleryTests
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import XCTest
@testable import MyGallery

class MyGalleryTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testAlbumGrouping() {
        let viewModel = AlbumsViewModel();
        let array = [Photo(albumId: 10, id: 1, title: nil, url: nil, thumbnailUrl: nil), Photo(albumId: 10, id: 2, title: nil, url: nil, thumbnailUrl: nil), Photo(albumId: 11, id: 3, title: nil, url: nil, thumbnailUrl: nil)]
        let groups = viewModel.groupImages(array)
        XCTAssertEqual(2, Array(groups.keys).count)
    }
    
    /**
     To test Async Web Service.
 */
    func testPhotosService()   {
        var images:[Photo]?
        var error:Error?
        let expectation = self.expectation(description: "Testing web api")
        ServiceManager.shared.fetchPhotos { (photos, err) in
            print("Hello \(photos?.count ?? 0)")
            images = photos
            error = err
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(images, "Data should not be nil")
        XCTAssertTrue(images!.count > 0)
        XCTAssertNil(error, "Error should be nil")
    }
}
