//
//  Sport.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct SportsResponse: Codable{
    var sports: Array<Sport>?
}

struct Sport: Codable {
    var idSport : String?
    var strSport : String?
    var strFormat : String?
    var strSportThumb : String?
    var strSportIconGreen : String?
    var strSportDescription : String?
}
