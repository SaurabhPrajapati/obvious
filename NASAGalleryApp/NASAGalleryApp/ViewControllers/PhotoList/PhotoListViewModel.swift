//
//  PhotoListViewModel.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation
import Combine

class PhotoListViewModel: JSONContentParser {
    var jsonContentType: JSONContentType { .photos }
    
    var decoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.yearMonthDay
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    private(set) var photos: [Photo]?
    private(set) var reloadData: PassthroughSubject<Void, Never> = PassthroughSubject()
    
    @discardableResult
    func fetchPhotos() throws -> [Photo] {
        var photos: [Photo] = try parseLocalData()
        photos = photos.sorted(by: { $0.date > $1.date })
        self.photos = photos
        reloadData.send()
        return photos
    }
}

extension PhotoListViewModel {
    func numberOfItems(inSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func getPhotoViewModel(atIndex index: Int) -> PhotoViewModel {
        return PhotoViewModel(photo: photos?[safe: index])
    }
}
