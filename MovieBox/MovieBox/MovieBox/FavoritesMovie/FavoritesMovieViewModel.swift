//
//  ViewModel.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 30.01.2023.
//

import Foundation

final class FavoriteListViewModel : FavoriteListViewModelProtocol {
  
    
    var delegate: FavoriteListViewModelDelegate?
    var dataPersistManager : DataPersistManagerProtocol!
    private var movieItems : [MovieItem] = []
    
    init(dataPersistManager: DataPersistManagerProtocol!) {
        self.dataPersistManager = dataPersistManager
    }
    
    func load() {
        dataPersistManager.fetchMoviesFromDatabase { result in
            switch result {
            case .success(let success):
                self.movieItems = success
                self.notify(.showMovieList(success))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func notify(_ output: FavoriteListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
