//
//  SearchVC.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit
import SDWebImage


class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    private var searchMovie : [MoviePresentation] = []

    var timer = Timer()
    var counter = 5
    var endSearchText = ""
    
    var viewModel : MovieSearchViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCollectionView.register(MovieSearchCell.self, forCellWithReuseIdentifier: "MovieSearchCell")
      
    }

}


extension SearchVC : MovieSearchViewModelDelegate {
    func handleViewModelOutput(_ output: MovieSearchViewModelOutput) {
        switch output {
        case .searchMovieList(let array):
            self.searchMovie = array
            self.searchCollectionView.reloadData()
        }
    }
    
    func navigate(_ route: MovieSearchRouter) {
        switch route {
        case .detail(let movieDetailViewModelProtocol):
            let viewController = MovieDetailBuilder.make(with: movieDetailViewModelProtocol)
            show(viewController, sender: nil)
        }
    }
    
    
}

extension SearchVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchMovieCell", for: indexPath) as! MovieSearchCell
        let resultMovie = searchMovie[indexPath.row]
        cell.searchTitle.text = resultMovie.title
        cell.searchImageView.sd_setImage(with: URL(string: "\(Util.TopMovieUrl.imagesUrl)\(resultMovie.image)"))
        return cell
    }
}

extension SearchVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO
        self.viewModel.selectedMovie(at: indexPath.row)
    }
}

extension SearchVC : UISearchBarDelegate {
    
 
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /*if searchText.isEmpty == true {
            self.searchMovie.removeAll(keepingCapacity: false)
            self.searchCollectionView.reloadData()
           
        }*/
  
         
        self.viewModel.text = searchText
        print(viewModel.text!)
        self.viewModel.searchMovie()
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
        
 
    }
}
