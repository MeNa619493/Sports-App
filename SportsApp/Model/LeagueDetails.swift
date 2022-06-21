//
//  LeagueDetails.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct EventsResponse: Codable {
    var events: Array<Event>?
}

struct Event: Codable {
    var idEvent: String?
    var strEvent: String?
    var dateEvent: String?
    var strTime: String?
    var strThumb: String?
    var strHomeTeam: String?
    var strAwayTeam: String?
    var intHomeScore: String?
    var intAwayScore: String?
}
