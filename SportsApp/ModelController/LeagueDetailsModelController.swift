//
//  LeagueDetailsController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class LeagueDetailsModelController: ILeagueDetailsModel {
    
    let networkManager: ApiService = NetworkManager()
    var iLeagueDetailsPresnter: ILeagueDetailsPresenter
    
    init(iLeagueDetailsPresnter: ILeagueDetailsPresenter) {
        self.iLeagueDetailsPresnter = iLeagueDetailsPresnter
    }
    
    func fetchDataFromApi(endPoint: String) {
        networkManager.fetchUpcomingEvents(endPoint: endPoint) { events, error in
            if let events = events {
                self.iLeagueDetailsPresnter.onSuccess(events: events)
            }
            
            if let error = error {
                self.iLeagueDetailsPresnter.onFail(error: error)
            }
        }
    }
}
