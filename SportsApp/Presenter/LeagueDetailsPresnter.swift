//
//  LeagueDetailsPresnter.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class LeagueDetailsPresnter: ILeagueDetailsPresenter {
    var leagueDetailsView: ILeagueDetailsview
    
    init(leagueDetailsView: ILeagueDetailsview) {
        self.leagueDetailsView = leagueDetailsView
    }
    
    func fetchData(endPointUpcomingEvents: String, endPointLatestResults: String, endPointTeams: String) {
        let leagueDetailsModel = LeagueDetailsModelController(iLeagueDetailsPresnter: self)
        leagueDetailsModel.fetchDataFromApi(endPointUpcomingEvents: endPointUpcomingEvents, endPointLatestResults: endPointLatestResults, endPointTeams: endPointTeams)
        
    }
    
    func onSuccessFetchingUpcomingEvents(upcomingEvents events: Array<Event>) {
        leagueDetailsView.renderUpcomingEventsView(upcomingEvents: events)
    }
    
    func onSuccessFetchingLatestResults(latestResults events: Array<Event>) {
        leagueDetailsView.renderLatestResultsView(latestResults: events)
    }
    
    func onSuccessFetchingTeams(teams: Array<Team>) {
        leagueDetailsView.renderTeamsView(teams: teams)
    }
    
    func onFail(error: Error) {
        leagueDetailsView.postErrorILeagueDetailsView(error: error)
    }
}
