//
//  FavoritesMovieViewController.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit
import CoreData
import SDWebImage
import UserNotifications

class FavoritesMovieViewController: UIViewController {


    @IBOutlet weak var favTableView: UITableView! {
        didSet {
            favTableView.dataSource = self
            favTableView.delegate = self
        }
    }
    private var favMovies : [MovieItem] = []
    
    var viewModel : FavoriteListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var dataPersistManager : DataPersistManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("saveMovie"), object: nil, queue: nil) { _ in
            self.viewModel.load()
            self.favTableView.reloadData()
        }
    }
}

extension FavoritesMovieViewController : FavoriteListViewModelDelegate {
    func handleViewModelOutput(_ output: FavoriteListViewModelOutput) {
        switch output {
        case .showMovieList(let array):
            self.favMovies = array
            self.favTableView.reloadData()
        }
    }
    
}


extension FavoritesMovieViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTableView.dequeueReusableCell(withIdentifier: "FavoritesMovieCell", for: indexPath) as! FavoritesMovieCell
        let movies = favMovies[indexPath.row]
        
        cell.favOverview.text = movies.overview
        cell.favTitleLabel.text = movies.title
        cell.favImageView.sd_setImage(with: URL(string: "\(Util.TopMovieUrl.imagesUrl)\(movies.image!)"))
        
        return cell
    }
}

extension FavoritesMovieViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform  = rotationTransform
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            dataPersistManager.deleteMovieWith(model: favMovies[indexPath.row])
            self.favMovies.remove(at: indexPath.row)
            self.favTableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break;
        }
    }
    
    
}



