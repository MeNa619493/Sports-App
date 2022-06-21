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
        // Initialization code
        sportsImage.layer.cornerRadius = sportsImage.frame.height / 2
    }
    
    func configureMainCell(sportsTitle: String, sportsImageurl: String) {
        sportsLabel.text = sportsTitle
        let url = URL(string: sportsImageurl)
        //sportsImage.sd_setImage(with: url, completed: nil)
        sportsImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
    }

}
