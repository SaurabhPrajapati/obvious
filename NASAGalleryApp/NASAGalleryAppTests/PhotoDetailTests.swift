//
//  PhotoDetailTests.swift
//  NASAGalleryAppTests
//
//  Created by Saurabh on 30/08/22.
//

import XCTest
@testable import NASAGalleryApp

class PhotoDetailTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func getPhotos() -> [Photo] {
        return (try? PhotoListViewModel().fetchPhotos()) ?? []
    }
    
    func testAPhotoDetailNavigation() {
        let photos = getPhotos()
        
        let detailViewModel = PhotoDetailViewModel(photos: photos, selectedIndex: 0)
        XCTAssertTrue(detailViewModel.selectedIndex == 0, "Test Failed - selectedIndex is incorrect")
        
        detailViewModel.swipe(.left)
        XCTAssertTrue(detailViewModel.selectedIndex == 1, "Left swipe failed")
        
        detailViewModel.swipe(.left)
        XCTAssertTrue(detailViewModel.selectedIndex == 2, "Left swipe failed")
        
        detailViewModel.swipe(.right)
        XCTAssertTrue(detailViewModel.selectedIndex == 1, "Right swipe failed")
        
        detailViewModel.swipe(.right)
        XCTAssertTrue(detailViewModel.selectedIndex == 0, "Right swipe failed")
        
        detailViewModel.swipe(.right)
        XCTAssertTrue(detailViewModel.selectedIndex == 0, "Right swipe failed")
    }

}
