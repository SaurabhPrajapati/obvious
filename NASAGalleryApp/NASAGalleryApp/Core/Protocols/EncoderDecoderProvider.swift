//
//  EncoderDecoderProvider.swift
//  NASAGalleryApp
//
//  Created by Saurabh on 26/08/22.
//

import Foundation
protocol EncoderDecoderProvider {
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

extension EncoderDecoderProvider {
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
