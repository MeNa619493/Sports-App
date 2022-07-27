//
//  MainCollectionViewCell.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import SDWebImage

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsLabel: UILabel!
    @IBOutlet weak var sportsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sportsImage.layer.cornerRadius = 12
        self.layer.cornerRadius = 12
    }
    
    func configureMainCell(sport: Sport) {
        sportsLabel.text = sport.strSport ?? "no value"
        if let url = URL(string: sport.strSportThumb ?? "no value") {
            sportsImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
    }

}
