//
//  PhotoListCell.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import UIKit
import Kingfisher

class PhotoListCell: UICollectionViewCell, Reusable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicatorView.stopAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(_ viewModel: PhotoViewModel) {
        guard
            let url = viewModel.getImageURL()
        else {
            return
        }
        
        indicatorView.startAnimating()
        imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo")) { [weak self] result in
            performOnMainThread {
                self?.indicatorView.stopAnimating()
            }
        }
        
        imageView.isHeroEnabled = true
        imageView.hero.id = viewModel.getTitle()
        imageView.heroModifiers = [.useGlobalCoordinateSpace, .useScaleBasedSizeChange]
    }
}
