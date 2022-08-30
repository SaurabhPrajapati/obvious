//
//  Collection+Safe.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation
extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
