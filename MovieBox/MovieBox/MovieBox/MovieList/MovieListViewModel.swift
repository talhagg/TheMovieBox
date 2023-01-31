//
//  MovieListViewModel.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 25.01.2023.
//

import Foundation
import MovieBoxAPI

final class MovieListViewModel: MovieListViewModelProtocol {
    
    weak var delegate: MovieListViewModelDelegate?
    private let service: TopMoviesServiceProtocol
    private var movies: [Movies] = []
    
    init(service: TopMoviesServiceProtocol) {
        self.service = service
    }
    
    func load() {
        notify(.updateTitle("Top Movies"))
        notify(.setLoading(false))
        
        service.fetchMovies(url: Util.TopMovieUrl.populerUrl) { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(true))
            
            switch result {
            case .success(let response):
                self.movies = response
                let presentations = response.map(MoviePresentation.init)
                self.notify(.showMovieList(presentations))
            case .failure(let error):
                print(error)
            }
        }
    }
        
        
        func selectMovie(at index: Int) {
            let movie = movies[index]
            let viewModel = MovieDetailViewModel(movie: movie)
            delegate?.navigate(to: .detail(viewModel))
        }
        
        private func notify(_ output: MovieListViewModelOutput) {
            delegate?.handleViewModelOutput(output)
        }
}

