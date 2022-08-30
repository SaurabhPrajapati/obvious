//
//  PhotoListViewController.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import UIKit
import Combine

class PhotoListViewController: UIViewController {

    private let viewModel: PhotoListViewModel
    private var reloadDataCancellable: AnyCancellable?
    
    init(viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PhotoListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupListeners()
        
        do {
            try viewModel.fetchPhotos()
        } catch {
            print(error)
        }
    }
    
    private func setupListeners() {
        reloadDataCancellable = viewModel
            .reloadData
            .sink(receiveValue: { [weak self] _ in
                self?.reloadData()
            })
    }
    
    @MainActor private func reloadData() {
        print("Reload UI")
    }
}

extension PhotoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCell.reuseIdentifier, for: indexPath) as! PhotoListCell
        cell.setup(viewModel.getPhotoViewModel(atIndex: indexPath.item))
        return cell
    }
}
