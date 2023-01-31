//
//  UpcomingMoviesContracts.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import Foundation


protocol UpcomingMovieViewModelProtocol {
    var delegate : UpcomingMovieViewModelDelegate? { get set }
    func load()
    func selectMovie(at index: Int)
}

enum UpcomingMovieViewModelOutput : Equatable {
    case setLoading(Bool)
    case showMovieList([MoviePresentation])
}

enum UpcomingMovieRouter {
    case detail(MovieDetailViewModelProtocol)
}

protocol UpcomingMovieViewModelDelegate : class{
    func handleViewModelOutput(_ output: UpcomingMovieViewModelOutput)
    func navigate(_ route: UpcomingMovieRouter)
}
