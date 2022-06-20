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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeCellRounded() {
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }
    
    func configureCell(homeTeam: String, awayTeam: String, homeScore: String, awayScore: String) {
        homeTeamLabel.text = homeTeam
        homeTeamScoreLabel.text = homeScore
        awayTeamLabel.text = awayTeam
        awayTeamScoreLabel.text = awayScore
    }
    
}
