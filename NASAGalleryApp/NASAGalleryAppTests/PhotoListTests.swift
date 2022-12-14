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
    
    func testCNumberOfItems() {
        let viewModel = PhotoListViewModel()
        
        do {
            let photos = try viewModel.fetchPhotos()
            XCTAssertTrue(viewModel.numberOfItems(inSection: 0) == photos.count, "Number of items not matched with number of photos")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDgetPhotoModel() {
        let viewModel = PhotoListViewModel()
        
        do {
            let photos = try viewModel.fetchPhotos()
            let photoModelTitle = viewModel.getPhotoViewModel(atIndex: 0).getTitle()
            XCTAssertTrue(photoModelTitle == photos.first?.title, "Wrong photo item model generated")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
