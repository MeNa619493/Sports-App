//
//  Sport.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct SportsResponse: Codable{
    let sports: Array<Sport>?
}

struct Sport: Codable {
    let idSport : String?
    let strSport : String?
    let strFormat : String?
    let strSportThumb : String?
    let strSportIconGreen : String?
    let strSportDescription : String?
}
