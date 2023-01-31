//
//  FavoritesMovieBuilder.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 28.01.2023.
//

import UIKit

final class FavoritesMovieBuilder {
    
    static func make() -> FavoritesMovieViewController {
        let storyboard = UIStoryboard(name: "FavoritesMovie", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoritesMovie") as! FavoritesMovieViewController
        let dataPersistManager = DataPersistenceManager()
        viewController.viewModel = FavoriteListViewModel(dataPersistManager: dataPersistManager)
        viewController.dataPersistManager = dataPersistManager
        return viewController
    }
}
