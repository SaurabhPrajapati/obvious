//
//  PhotoListViewModel.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation
import Combine
import UIKit

struct GridSpecs {
    let numberOfGrids: Int = 3
    let interItemSpacing: CGFloat = 16.0
    let lineSpacing: CGFloat = 16.0
}

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
    private(set) var gridSpecs = GridSpecs()
    private(set) var navigationController: UINavigationController?
    
    deinit {
        print("Deinit - PhotoListViewModel")
    }
    
    func setNavigationController(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func fetchPhotos() throws -> [Photo] {
        var photos: [Photo] = try parseLocalData()
        photos = photos.sorted(by: { $0.date > $1.date })
        self.photos = photos
        reloadData.send()
        return photos
    }
    
    func setGridSpecifications(_ gridSpecs: GridSpecs) {
        self.gridSpecs = gridSpecs
        self.reloadData.send()
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

extension PhotoListViewModel {
    func showDetail(_ viewModel: PhotoViewModel?) {
        guard
            let viewModel = viewModel else {
            return
        }

        let detailViewController = PhotoDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
