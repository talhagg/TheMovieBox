//
//  UpcomingMovieBuilder.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit
import MovieBoxAPI

final class UpcomingMovieBuilder {
    
    static func make() -> UpcomingMovie {
        let storyboard = UIStoryboard(name: "UpcomingMovie", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UpcomingMovie") as! UpcomingMovie
        let service = TopMoviesService()
        view.viewModel = UpcomingMovieViewModel(service: service)
        return view
    }
    
}
