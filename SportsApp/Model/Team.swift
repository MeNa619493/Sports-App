//
//  Team.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

struct TeamResponse: Codable {
    var teams: Array<Team>?
}

struct Team: Codable {
    var idTeam: String?
    var strTeam: String?
    var strLeague: String?
    var strStadiumThumb: String?
    var strTeamBadge: String?
}
