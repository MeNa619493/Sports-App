//
//  FavouriteLeagueModelController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class FavouriteLeagueModelController: IFavouriteLeagueModel {
    
    let dataBaseManager: DatabaseService = DatabaseManager()
    let iFavouriteLeaguePresenter: IFavouriteLeaguePresenter
    
    init(iFavouriteLeaguePresenter: IFavouriteLeaguePresenter) {
        self.iFavouriteLeaguePresenter = iFavouriteLeaguePresenter
    }
    
    func fetchDataFromCoredata(appDelegate: AppDelegate) {
        dataBaseManager.fetchFavouriteLeauges(appDelegate: appDelegate) { leagues in
            if let leagues = leagues {
                self.iFavouriteLeaguePresenter.onSuccess(leagues: leagues)
            }
        }
    }
    
    func deleteLeagueFromCoredata(appDelegate: AppDelegate, league: League) {
        dataBaseManager.deleteLeagueFromFavourites(appDelegate: appDelegate, league: league)
    }
}
