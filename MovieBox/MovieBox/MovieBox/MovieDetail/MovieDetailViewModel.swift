//
//  MovieDetailViewModel.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 25.01.2023.
//

import Foundation
import MovieBoxAPI


final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    weak var delegate: MovieDetailViewModelDelegate?
    private let presentation: MoviePresentation
    
    init(movie: Movies) {
        self.presentation = MoviePresentation(movie: movie)
    }
    
    func load() {
        delegate?.showDetail(presentation)
    }
}
