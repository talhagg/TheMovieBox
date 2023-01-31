//
//  Util.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 21.01.2023.
//

import Foundation


struct Util {
    public struct TopMovieUrl {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let movie = "/movie/popular?"
        static let upcoming = "/movie/upcoming?"
        static let apiKey = "api_key=41cd859e1db374e44c4a8b456b13819f"
        static let endUrl = "&language=en-US&page=1"
        static let imagesUrl = "https://www.themoviedb.org/t/p/w1280"
        static let populerUrl = "\(baseUrl)\(movie)\(apiKey)\(endUrl)"
        static let upcomingUrl = "\(baseUrl)\(upcoming)\(apiKey)\(endUrl)"
        
    }
    
    public struct SearchMovieUrl {
        static let baseUrl = "https://api.themoviedb.org/3"
        static let search = "/search/movie?"
        static let apiKey = "api_key=41cd859e1db374e44c4a8b456b13819f"
        static var query = "Inception"
        static let language = "&language=en-US&query="
        static let searchUrl = "\(baseUrl)\(search)\(apiKey)\(language)\(query)"
    }
}
