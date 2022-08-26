//
//  DataParsingError.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation

enum DataParsingError: Error {
    case fileNotFound
}

extension DataParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        }
    }
}
