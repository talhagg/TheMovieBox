//
//  UpcomingMovieViewModel.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import Foundation
import MovieBoxAPI


final class UpcomingMovieViewModel : UpcomingMovieViewModelProtocol {
    var delegate: UpcomingMovieViewModelDelegate?
    private let service : TopMoviesServiceProtocol!
    private var upcomingMovies : [Movies] = []
    
    init(service: TopMoviesServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.setLoading(false))
        service.fetchMovies(url: Util.TopMovieUrl.upcomingUrl) { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(true))
            
            switch result {
            case .success(let movie):
                self.upcomingMovies = movie
                let presentation = movie.map(MoviePresentation.init)
                self.notify(.showMovieList(presentation))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func selectMovie(at index: Int) {
        let movie = upcomingMovies[index]
        let viewModel = MovieDetailViewModel(movie: movie)
        delegate?.navigate(.detail(viewModel))
    }
    
    func notify(_ output: UpcomingMovieViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
