//
//  Contracts.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 30.01.2023.
//

import Foundation
import MovieBoxAPI


protocol FavoriteListViewModelProtocol {
    var delegate: FavoriteListViewModelDelegate? { get set }
    func load()
}

enum FavoriteListViewModelOutput: Equatable {
    case showMovieList([MovieItem])
}



protocol FavoriteListViewModelDelegate: class {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput)
}
