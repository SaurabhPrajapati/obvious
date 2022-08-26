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
