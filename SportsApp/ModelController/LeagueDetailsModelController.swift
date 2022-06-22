//
//  LeagueDetailsController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class LeagueDetailsModelController: ILeagueDetailsModel {
    
    let databaseManager: DatabaseService = DatabaseManager()
    let networkManager: ApiService = NetworkManager()
    var iLeagueDetailsPresnter: ILeagueDetailsPresenter
    
    init(iLeagueDetailsPresnter: ILeagueDetailsPresenter) {
        self.iLeagueDetailsPresnter = iLeagueDetailsPresnter
    }
    
    func fetchDataFromApi(endPointUpcomingEvents: String, endPointLatestResults: String, endPointTeams: String){
        networkManager.fetchUpcomingEvents(endPoint: endPointUpcomingEvents) { events, error in
            if let events = events {
                self.iLeagueDetailsPresnter.onSuccessFetchingUpcomingEvents(upcomingEvents: events)
            }
            
            if let error = error {
                self.iLeagueDetailsPresnter.onFail(error: error)
            }
        }
        
        networkManager.fetchLatestResults(endPoint: endPointLatestResults){ events, error in
            if let events = events {
                self.iLeagueDetailsPresnter.onSuccessFetchingLatestResults(latestResults: events)
            }
            
            if let error = error {
                self.iLeagueDetailsPresnter.onFail(error: error)
            }
        }
        
        networkManager.fetchTeams(endPoint: endPointTeams) { teams, error in
            if let teams = teams {
                self.iLeagueDetailsPresnter.onSuccessFetchingTeams(teams: teams)
            }
            
            if let error = error {
                self.iLeagueDetailsPresnter.onFail(error: error)
            }
        
        }
    }
    
    func saveFavouriteLeauges(appDelegate: AppDelegate, league: League) {
        databaseManager.saveFavouriteLeauges(appDelegate: appDelegate, league: league)
    }
    
    func fetchDataFromCoredata(appDelegate: AppDelegate) {
        databaseManager.fetchFavouriteLeauges(appDelegate: appDelegate) { leagues in
            if let leagues = leagues {
                self.iLeagueDetailsPresnter.onSuccessFetchingFavouriteLeagues(leagues: leagues)
            }
        }
    }
    
    func deleteLeagueFromCoredata(appDelegate: AppDelegate, league: League) {
        databaseManager.deleteLeagueFromFavourites(appDelegate: appDelegate, league: league)
    }
}
