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

    @IBOutlet weak var teamStaduimImage: UIImageView!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamJersyImage: UIImageView!
    @IBOutlet weak var teamFormedYearLabel: UILabel!
    
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    @IBOutlet weak var teamStaduimLabel: UILabel!
    
    @IBOutlet weak var teamStaduimDescriptionLabel: UILabel!
    @IBOutlet weak var teamBannerImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: team?.strTeamBadge ?? "no value"){
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
        
        if let url = URL(string: team?.strStadiumThumb ?? "no value"){
            teamStaduimImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
        
        if let url = URL(string: team?.strTeamJersey ?? "no value"){
            teamJersyImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
        
        if let url = URL(string: team?.strTeamBanner ?? "no value"){
            teamBannerImage.sd_setImage(with: url, placeholderImage: UIImage(named: "SM-placeholder.png"))
        }
        
        teamNameLabel.text = team?.strTeam
        teamFormedYearLabel.text = team?.intFormedYear
        teamDescriptionLabel.text = team?.strDescriptionEN
        teamStaduimLabel.text = team?.strStadium
        teamStaduimDescriptionLabel.text = team?.strStadiumDescription
        
    }
    

    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTwitterButtonPressed(_ sender: UIButton) {
        goForwardLink(input: team?.strTwitter)
    }
    
    @IBAction func onWebsiteButtonPressed(_ sender: UIButton) {
        goForwardLink(input: team?.strWebsite)
    }
    
    
    @IBAction func onFacebookButtonPressed(_ sender: UIButton) {
        goForwardLink(input: team?.strFacebook)
    }
    
    
    
    @IBAction func onYoutubeButtonPressed(_ sender: UIButton) {
        goForwardLink(input: team?.strYoutube)
    }
    
    
    @IBAction func onIstgramButtonPressed(_ sender: UIButton) {
        goForwardLink(input: team?.strInstagram)
    }
    
    
    func goForwardLink(input: String?) {
        if let link = input {
            if !link.isEmpty {
                guard let url = URL(string: "https://\(link)") else {
                    showAlert()
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showAlert()
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Sorry", message: "We have not that link.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

}
