//
//  MovieListBuilder.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 25.01.2023.
//

import UIKit
import MovieBoxAPI

final class MovieListBuilder {
    
    static func make() -> MovieVC {
        let storyboard = UIStoryboard(name: "MovieVC", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieVC") as! MovieVC
        let service = TopMoviesService()
        view.viewModel = MovieListViewModel(service: service)
        return view
    }
    
}
