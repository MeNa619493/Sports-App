//
//  UpcomingEventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import SDWebImage

class UpcomingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var upcomingImage: UIImageView!
    
    @IBOutlet weak var teamsLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(imageUrl: String, teamsName: String, date: String, hour: String) {
        if let url = URL(string: imageUrl) {
            upcomingImage.sd_setImage(with: url, completed: nil)
        }
        teamsLabel.text = teamsName
        dateLabel.text = date
        hourLabel.text = hour.substring(to: 5)
    }
}

extension String {
     func index(from: Int) -> Index {
           return self.index(startIndex, offsetBy: from)
       }

       func substring(from: Int) -> String {
           let fromIndex = index(from: from)
           return String(self[fromIndex...])
       }

       func substring(to: Int) -> String {
           let toIndex = index(from: to)
           return String(self[..<toIndex])
       }

       func substring(with r: Range<Int>) -> String {
           let startIndex = index(from: r.lowerBound)
           let endIndex = index(from: r.upperBound)
           return String(self[startIndex..<endIndex])
       }
}
