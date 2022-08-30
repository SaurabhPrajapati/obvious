//
//  Reusable.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
