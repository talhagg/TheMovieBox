//
//  MoviePresentation.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 22.01.2023.
//

import Foundation
import MovieBoxAPI

struct MoviePresentation: Equatable {
    let id : Int
    let title : String
    let overview: String
    let image : String
    let vote : Float
    let date : String
}

extension MoviePresentation {
    init(movie: Movies) {
        self.init(id: movie.id, title: movie.title, overview: movie.overview, image: movie.image, vote: movie.vote, date: movie.releaseDate)
    }
}
