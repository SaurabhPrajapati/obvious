//
//  PhotoListViewController.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import UIKit
import Combine
import Hero

class PhotoListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
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

        setupCollectionView()
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
    
    private func setupCollectionView() {
        collectionView.hero.isEnabled = true
        collectionView.heroModifiers = [.cascade]
        
        PhotoListCell.registerNib(to: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        cell.heroModifiers = [.fade]
        return cell
    }
}

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetail(with: indexPath.item)
    }
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let grids = CGFloat(viewModel.gridSpecs.numberOfGrids)
        let spacing = (grids - 1) * viewModel.gridSpecs.interItemSpacing
        
        // |item-spacing-item|
        let width = (collectionViewWidth - spacing)/grids
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.gridSpecs.interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.gridSpecs.lineSpacing
    }
}
