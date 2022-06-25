//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import SDWebImage

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        teamImage.layer.cornerRadius = teamImage.frame.height / 2
    }

    func configureCell(team: Team) {
        if let url = URL(string: team.strTeamBadge ?? "no value") {
        teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
        teamName.text = team.strTeam ?? "no value"
    }
    
}
