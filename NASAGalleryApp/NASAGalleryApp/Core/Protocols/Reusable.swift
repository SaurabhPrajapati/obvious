//
//  Reusable.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UICollectionViewCell {
    static func registerNib(to collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
}
