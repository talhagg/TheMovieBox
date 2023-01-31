//
//  MovieListContracts.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 25.01.2023.
//

import Foundation
import MovieBoxAPI


protocol MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate? { get set }
    func load()
    func selectMovie(at index: Int)
}

enum MovieListViewModelOutput: Equatable {
    case updateTitle(String)
    case setLoading(Bool)
    case showMovieList([MoviePresentation])
}

enum MovieListViewRoute {
    case detail(MovieDetailViewModelProtocol)
}

protocol MovieListViewModelDelegate: class {
    func handleViewModelOutput(_ output: MovieListViewModelOutput)
    func navigate(to route: MovieListViewRoute)
}
