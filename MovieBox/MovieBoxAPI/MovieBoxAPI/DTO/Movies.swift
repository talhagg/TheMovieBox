//
//  Movies.swift
//  MovieBoxAPI
//
//  Created by Talha Gölcügezli on 20.01.2023.
//

import Foundation


public struct Movies: Decodable, Equatable {
    
    public enum CodingKeys : String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case image = "poster_path"
        case releaseDate = "release_date"
        case vote = "vote_average"
    }
    
    public let id : Int
    public let title : String
    public let overview : String
    public let image : String
    public let releaseDate : String
    public let vote : Float
}
