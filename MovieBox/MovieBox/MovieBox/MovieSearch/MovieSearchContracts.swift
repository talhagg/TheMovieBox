//
//  MovieSearchContracts.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 27.01.2023.
//

import Foundation

protocol MovieSearchViewModelProtocol : class {
    var delegate : MovieSearchViewModelDelegate? { get set }
    func searchMovie()
    func selectedMovie(at index: Int)
    var text : String? { get set }
}

enum MovieSearchViewModelOutput {
    case searchMovieList([MoviePresentation])
}

enum MovieSearchRouter {
    case detail(MovieDetailViewModelProtocol)
}

protocol MovieSearchViewModelDelegate : class {
    func handleViewModelOutput(_ output: MovieSearchViewModelOutput)
    func navigate(_ route: MovieSearchRouter)
}
