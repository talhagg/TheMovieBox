//
//  UpcomingVC.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit
import SDWebImage

class UpcomingMovie: UIViewController {
    

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.layer.cornerRadius = 20
            tableView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var upcomingLoading: UIActivityIndicatorView!
    
    var upcomingMovies : [MoviePresentation] = []
    
    var viewModel : UpcomingMovieViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
    


}

extension UpcomingMovie : UpcomingMovieViewModelDelegate {
    func handleViewModelOutput(_ output: UpcomingMovieViewModelOutput) {
        switch output {
        case .setLoading(let bool):
            self.upcomingLoading.isHidden = bool
        case .showMovieList(let array):
            self.upcomingMovies = array
            self.tableView.reloadData()
        }
    }
    
    func navigate(_ route: UpcomingMovieRouter) {
        switch route {
        case .detail(let movieDetailViewModelProtocol):
            let viewController = MovieDetailBuilder.make(with: movieDetailViewModelProtocol)
            show(viewController, sender: nil)
        }
        
    }
    
}

extension UpcomingMovie : UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMovieCell", for: indexPath) as! UpcomingMovieCell
        let movies = upcomingMovies[indexPath.row]
        
        cell.upcomingTitle.text = movies.title
        cell.upcomingImageView.sd_setImage(with: URL(string: "\(Util.TopMovieUrl.imagesUrl)\(movies.image)"))
        cell.upcomingDate.text = movies.date
        cell.upcomingVote.text = String(movies.vote)
        
        return cell
    }
}

extension UpcomingMovie : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectMovie(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform  = rotationTransform
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}
