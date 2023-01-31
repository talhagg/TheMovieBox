//
//  Decoders.swift
//  MovieBoxAPI
//
//  Created by Talha Gölcügezli on 20.01.2023.
//

import Foundation


public enum Decoders {
    static let plaindDateDecoder : JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormetter)
        return decoder
    }()
}
