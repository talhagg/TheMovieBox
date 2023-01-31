//
//  MovieDetailBuilder.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 25.01.2023.
//

import UIKit
import MovieBoxAPI

final class MovieDetailBuilder {
    
    static func make(with viewModel: MovieDetailViewModelProtocol) -> DetailVC {
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetail") as! DetailVC
        let dataPersistManager = DataPersistenceManager()
        viewController.dataPersistManager = dataPersistManager
        viewController.viewModel = viewModel
        return viewController
    }
}
