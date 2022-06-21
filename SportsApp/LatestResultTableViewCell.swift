//
//  LatestResultTableViewCell.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class LatestResultTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(latestResult: Event) {
        
        homeTeamLabel.text = latestResult.strHomeTeam ?? "no value"
        homeTeamScoreLabel.text = latestResult.intHomeScore ?? "no value"
        awayTeamLabel.text = latestResult.strAwayTeam ?? "no value"
        awayTeamScoreLabel.text = latestResult.intAwayScore ?? "no value"
    }
    
}
