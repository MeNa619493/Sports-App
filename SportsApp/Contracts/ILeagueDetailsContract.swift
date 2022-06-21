//
//  ILeagueDetailsContract.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol ILeagueDetailsview {
    func renderUpcomingEventsView(upcomingEvents: Array<Event>)
    func renderLatestResultsView(latestResults: Array<Event>)
    func renderTeamsView(teams: Array<Team>)
    func postErrorILeagueDetailsView(error: Error)
}

protocol ILeagueDetailsPresenter {
    func fetchData(endPointUpcomingEvents: String, endPointLatestResults: String, endPointTeams: String)
    func onSuccessFetchingUpcomingEvents(upcomingEvents: Array<Event>)
    func onSuccessFetchingLatestResults(latestResults: Array<Event>)
    func onSuccessFetchingTeams(teams: Array<Team>)
    func onFail(error: Error)
}

protocol ILeagueDetailsModel { 
    func fetchDataFromApi(endPointUpcomingEvents: String, endPointLatestResults: String, endPointTeams: String)
}
