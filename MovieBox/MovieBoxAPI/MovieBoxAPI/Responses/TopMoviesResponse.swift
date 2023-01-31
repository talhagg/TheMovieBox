//
//  TopMoviesResponse.swift
//  MovieBoxAPI
//
//  Created by Talha Gölcügezli on 20.01.2023.
//

import Foundation

public struct TopMoviesResponse : Decodable {

    private enum RootCodingKeys : String, CodingKey {
        case results
    }
    
    let result : [Movies]
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.result = try rootContainer.decode([Movies].self, forKey: .results)
    }
}
