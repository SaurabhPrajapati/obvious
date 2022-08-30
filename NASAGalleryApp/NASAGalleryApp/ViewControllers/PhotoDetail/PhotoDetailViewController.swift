//
//  PhotoDetailViewController.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import UIKit
import Hero
import Kingfisher

class PhotoDetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    private let viewModel: PhotoViewModel
    init(viewModel: PhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "PhotoDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
    }
    
    private func setupImageView() {
        imageView.hero.isEnabled = true
        imageView.hero.id = viewModel.getTitle()
        
        if let url = viewModel.getImageURL() {
            indicatorView.startAnimating()
            imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo")) { [weak self] result in
                performOnMainThread {
                    self?.indicatorView.stopAnimating()
                }
            }
        }
    }
}
