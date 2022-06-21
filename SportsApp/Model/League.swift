//
//  League.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/19/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct LeaguesResponse: Codable {
    var countries: Array<League>?
}

struct League: Codable {
    var idLeague: String?
    var strSport: String?
    var strYoutube:String?
    var strBadge:String?
    var strLeague:String?
    var isFavourite: Bool = false
}

