//
//  PhotoListTests.swift
//  NASAGalleryAppTests
//
//  Created by Saurabh on 26/08/22.
//

import XCTest
@testable import NASAGalleryApp

class PhotoListTests: XCTestCase {
    func testAFetchPhotos() {
        let viewModel = PhotoListViewModel()
        
        do {
            let photos = try viewModel.fetchPhotos()
            XCTAssertFalse(photos.isEmpty, "Photos are empty")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testBSortingPhotos() {
        let viewModel = PhotoListViewModel()
        
        do {
            let photos = try viewModel.fetchPhotos()
            
            if let first = photos.first,
               let second = photos[safe: 1] {
                XCTAssertTrue(first.date > second.date)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
