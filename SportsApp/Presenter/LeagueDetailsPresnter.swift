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
    
    func fetchData(endPoint: String) {
        let leagueDetailsModel = LeagueDetailsModelController(iLeagueDetailsPresnter: self)
        leagueDetailsModel.fetchDataFromApi(endPoint: endPoint)
        
    }
    
    func onSuccess(events: Array<Event>) {
        leagueDetailsView.renderLeagueDetailsView(events: events)
    }
    
    func onFail(error: Error) {
        leagueDetailsView.postErrorILeagueDetailsView(error: error)
    }
}
