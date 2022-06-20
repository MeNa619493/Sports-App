//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import SDWebImage

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leaugeImage: UIImageView!
    
    @IBOutlet weak var leaugeLabel: UILabel!
    
    @IBOutlet weak var containerViewOfCell: UIView!
    
    var urlYoutube: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureLeaugeCell(LeagueTitle: String, LeagueImageurl: String, urlYoutube: String) {
        leaugeLabel.text = LeagueTitle
        let url = URL(string: LeagueImageurl)
        leaugeImage.sd_setImage(with: url, completed: nil)
        self.urlYoutube = urlYoutube
    }
    
    func makeCellRounded() {
        containerViewOfCell.layer.cornerRadius = containerViewOfCell.frame.height / 2
        leaugeImage.layer.cornerRadius = leaugeImage.frame.height / 2
    }
    
    @IBAction func onYoutubePressed(_ sender: Any) {
        
        guard let urlYoutube = urlYoutube else {
            return
        }
        
        if !urlYoutube.isEmpty {
            guard let url = URL(string: "https://\(urlYoutube)") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("inavalid url")
        }
    }
    
}
