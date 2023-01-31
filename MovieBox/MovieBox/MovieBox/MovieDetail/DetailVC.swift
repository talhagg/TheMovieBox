//
//  DetailVC.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 22.01.2023.
//

import UIKit
import SDWebImage
import MovieBoxAPI
import CoreData
import UserNotifications


class DetailVC: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var voteLabel: UILabel!
    
    var viewModel: MovieDetailViewModelProtocol!
    var dataPersistManager : DataPersistManagerProtocol!
    var savePresentation : MoviePresentation!
    
    let notification = UNMutableNotificationContent()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.load()
    }
    
    @IBAction func favButtonClicked(_ sender: Any) {
            self.favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            dataPersistManager.saveMovies(model: savePresentation)
            NotificationCenter.default.post(name: NSNotification.Name("saveMovie"), object: nil)
            createNotfications()
    }
    
}

extension DetailVC : MovieDetailViewModelDelegate {
    
    func showDetail(_ presentation: MoviePresentation) {
        detailTitle.text = presentation.title
        overviewLabel.text = presentation.overview
        dateLabel.text = presentation.date
        detailImageView.sd_setImage(with: URL(string: "\(Util.TopMovieUrl.imagesUrl)\(presentation.image)"))
        voteLabel.text = String(presentation.vote)
        self.savePresentation = presentation
    }
}

extension DetailVC {
    func alert() {
        let alert = UIAlertController(title: "Delete", message: "Favorites Movies is delete?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Yes", style: .default) { action in
            self.favButton.setImage(UIImage(systemName: "star"), for: .normal)

        }
        let noButton = UIAlertAction(title: "No", style: .default)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true)
    }
}

extension DetailVC {
    func createNotfications() {
        notification.body = "Want to browse the movies you've recorded?"
    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let show = UNNotificationRequest(identifier: "Movie Notification", content: notification, trigger: trigger)
        
        UNUserNotificationCenter.current().add(show)
       }
    
}

