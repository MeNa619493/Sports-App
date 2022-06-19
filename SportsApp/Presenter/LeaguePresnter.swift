//
//  LeaguePresnter.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/19/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class LeaguePresenter: ILeaguePresenter {
    let leagueView: ILeagueView
    
    init(leagueView: ILeagueView) {
        self.leagueView = leagueView
    }
    
    func fetchData(endPoint: String) {
        let leagueModel = LeagueModelController(iLeaguePresenter: self)
        leagueModel.fetchDataFromApi(endPoint: endPoint)
    }
    
    func onSuccess(leagues: Array<League>) {
        leagueView.renderLeagueView(leagues: leagues)
    }
    
    func onFail(error: Error) {
        leagueView.postErrorLeagueView(error: error)
    }
    
    
}
