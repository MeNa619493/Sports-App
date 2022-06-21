//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController {
    
    var team: Team?

    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var teamCountryLabel: UILabel!
    
    @IBOutlet weak var teamSportLabel: UILabel!
    
    @IBOutlet weak var teamFormedYearLabel: UILabel!
    
    @IBOutlet weak var teamPerfaceText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamImage.layer.cornerRadius = teamImage.frame.height / 2
        if let url = URL(string: team?.strTeamBadge ?? "no value"){
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
        
        teamNameLabel.text = team?.strTeam
        teamCountryLabel.text = team?.strCountry
        teamSportLabel.text = team?.strSport
        teamFormedYearLabel.text = team?.intFormedYear
        teamPerfaceText.text = team?.strDescriptionEN
    }
    

    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
