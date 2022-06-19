//
//  LeagueModelController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/19/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class LeagueModelController: ILeagueModel {
    let networkManager: ApiService = NetworkManager()
    let iLeaguePresenter: ILeaguePresenter
    
    init(iLeaguePresenter: ILeaguePresenter) {
        self.iLeaguePresenter = iLeaguePresenter
    }
    
    func fetchDataFromApi(endPoint: String) {
        networkManager.fetchLeauges(endPoint: endPoint) { leagues, error in
            
            if let leagues = leagues {
                self.iLeaguePresenter.onSuccess(leagues: leagues)
            }
            
            if let error = error {
                self.iLeaguePresenter.onFail(error: error)
            }
        }
    }
    
}
