//
//  MainTabBarViewController.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let vc1 = MovieListBuilder.make()
        let vc2 = UpcomingMovieBuilder.make()
        let vc3 = FavoritesMovieBuilder.make()
        let vc4 = MovieSearchBuilder.make()
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "star")
        vc4.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        vc1.title = "Top Movies"
        vc2.title = "Upcoming"
        vc3.title = "Favorites"
        vc4.title = "Search"
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }
    



}
