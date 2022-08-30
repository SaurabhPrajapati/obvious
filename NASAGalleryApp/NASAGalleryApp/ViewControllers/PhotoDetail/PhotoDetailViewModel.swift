//
//  PhotoDetailViewModel.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import Foundation
import Combine
import UIKit

class PhotoDetailViewModel {
    private let photos: [Photo]?
    private var selectedIndex: Int
    
    @Published private(set) var photoModel: PhotoViewModel?
    
    init(photos: [Photo]?, selectedIndex: Int) {
        self.photos = photos
        self.selectedIndex = selectedIndex
        updatePhotoModel()
    }
    
    func swipe(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .right:
            guard
                selectedIndex > 0
            else {
                return
            }
            
            selectedIndex -= 1
        case .left:
            guard
                let totalPhotos = photos?.count,
                selectedIndex < totalPhotos - 1
            else {
                return
            }
            
            selectedIndex += 1
        default:
            return
        }
        
        updatePhotoModel()
    }
    
    private func updatePhotoModel() {
        let photo = self.photos?[safe: selectedIndex]
        self.photoModel = PhotoViewModel(photo: photo)
    }
}
