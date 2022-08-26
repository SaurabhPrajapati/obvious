//
//  LocalJSONParser.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation

enum JSONContentType {
    case photos
    
    var fileName: String {
        switch self {
        case .photos:
            return "data.json"
        }
    }
}

protocol JSONContentParser: EncoderDecoderProvider {
    var jsonContentType: JSONContentType { get }
}

extension JSONContentParser {
    func parseLocalData<T: Decodable>() throws -> T {
        let fileName = jsonContentType.fileName
        
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: nil)
        else {
            throw DataParsingError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
}
