//
//  PhotoViewModel.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import Foundation

class PhotoViewModel {
    private let photo: Photo?
    
    init(photo: Photo?) {
        self.photo = photo
    }
    
    deinit {
        print("Deinit - PhotoViewModel")
    }
    
    func getImageURL() -> URL? {
        guard
            let urlString = photo?.url
        else {
            return nil
        }
        return URL(string: urlString)
    }
    
    func getTitle() -> String? { photo?.title }
    
    func getExplanationText() -> String? { photo?.explanation }
}
