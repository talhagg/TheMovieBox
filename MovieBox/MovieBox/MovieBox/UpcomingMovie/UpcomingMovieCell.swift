//
//  UpcomingMovieCell.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 26.01.2023.
//

import UIKit

class UpcomingMovieCell: UITableViewCell {

    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var upcomingTitle: UILabel!
    @IBOutlet weak var upcomingDate: UILabel!
    @IBOutlet weak var upcomingVote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
