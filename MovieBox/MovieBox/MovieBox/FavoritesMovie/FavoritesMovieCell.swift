//
//  FavoritesMovieCell.swift
//  MovieBox
//
//  Created by Talha Gölcügezli on 30.01.2023.
//

import UIKit

class FavoritesMovieCell: UITableViewCell {

    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favTitleLabel: UILabel!
    @IBOutlet weak var favOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
