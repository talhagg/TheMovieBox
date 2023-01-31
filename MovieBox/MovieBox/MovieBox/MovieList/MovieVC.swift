//
//  ViewController.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 20.01.2023.
//

import UIKit
import SDWebImage
import MovieBoxAPI

class MovieVC: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    private var movieList : [MoviePresentation] = []
    
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
     
        viewModel.load()
        
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: "MovieListCell")
    }
}

extension MovieVC: MovieListViewModelDelegate {
    
    func handleViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            self.loadingView.isHidden = isLoading
        case .showMovieList(let movieList):
            self.movieList = movieList
            collectionView.reloadData()
        }
    }
    
    func navigate(to route: MovieListViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = MovieDetailBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}


extension MovieVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieListCell
        let movies = movieList[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: "\(Util.TopMovieUrl.imagesUrl)\(movies.image)"))
        cell.titleLabel.text = movies.title
        cell.progressView.setProgress(movies.vote / 10, animated: true)
        cell.voteLabel.text =  String(movies.vote)
        
        return cell
    }

}

extension MovieVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        self.viewModel.selectMovie(at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform  = rotationTransform
        cell.alpha = 0.25
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}

