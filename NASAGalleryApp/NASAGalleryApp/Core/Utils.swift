//
//  Utils.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 30/08/22.
//

import Foundation

func performOnMainThread(completion: @escaping (() -> Void)) {
    guard
        Thread.isMainThread
    else {
        DispatchQueue.main.async {
            completion()
        }
        return
    }
    completion()
}
