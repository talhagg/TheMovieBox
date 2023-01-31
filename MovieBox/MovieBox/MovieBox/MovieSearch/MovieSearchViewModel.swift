//
//  MovieSearchViewModel.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import Foundation
import MovieBoxAPI

final class MovieSearchViewModel : MovieSearchViewModelProtocol {
    var text: String?
    

    var delegate: MovieSearchViewModelDelegate?
    private var searchMovies : [Movies] = []
    private var service : TopMoviesServiceProtocol
    
    
    init(service : TopMoviesServiceProtocol) {
        self.service = service
    }
    
    func searchMovie() {
        Util.SearchMovieUrl.query = text!
        service.fetchMovies(url: Util.SearchMovieUrl.searchUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let search):
                self.searchMovies = search
                let response = search.map(MoviePresentation.init)
                self.notify(.searchMovieList(response))
            case .failure(let error):
                print(error)
            }
            
        }
     
    }
    
    func selectedMovie(at index: Int) {
        let searchMovies = searchMovies[index]
        let viewModel = MovieDetailViewModel(movie: searchMovies)
        delegate?.navigate(.detail(viewModel))
    }
    
    func notify(_ output: MovieSearchViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
