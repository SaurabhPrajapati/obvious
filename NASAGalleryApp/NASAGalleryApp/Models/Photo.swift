//
//  Photo.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation
struct Photo: Decodable {
    let title: String
    let explanation: String
    let hdurl: String?
    let url: String
    let date: Date
    let mediaType: MediaType
    
    let copyright: String?
    let serviceVersion: String?
}

enum MediaType: String, Decodable {
    case image
}
