//
//  MovieDetailContracts.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 25.01.2023.
//

import Foundation

protocol MovieDetailViewModelDelegate: class {
    func showDetail(_ presentation: MoviePresentation)
}

protocol MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? { get set }
    func load()
}
