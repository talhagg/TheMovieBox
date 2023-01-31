//
//  MovieSearchBuilder.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit
import MovieBoxAPI

final class MovieSearchBuilder {
    
    static func make() -> SearchVC {
        let storyboard = UIStoryboard(name: "MovieSearch", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieSearch") as! SearchVC
        let service = TopMoviesService()
        view.viewModel = MovieSearchViewModel(service: service)
        return view
    }
    
}
