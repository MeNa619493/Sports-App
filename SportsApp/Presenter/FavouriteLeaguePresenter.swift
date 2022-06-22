//
//  FavouriteLeaguePresenter.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class FavouriteLeaguePresenter: IFavouriteLeaguePresenter {
    
    let favouriteLeagueView: IFavouriteLeagueView
    var favouriteLeagueModel: IFavouriteLeagueModel?
    
    init(favouriteLeagueView: IFavouriteLeagueView) {
        self.favouriteLeagueView = favouriteLeagueView
    }
    
    
    func fetchData(appDelegate: AppDelegate) {
        favouriteLeagueModel = FavouriteLeagueModelController(iFavouriteLeaguePresenter: self)
        favouriteLeagueModel!.fetchDataFromCoredata(appDelegate: appDelegate)
    }
    
    func onSuccess(leagues: Array<League>) {
        favouriteLeagueView.renderFavouriteLeagueView(leagues: leagues)
    }
    
    func deleteLeagueFromCoredata(appDelegate: AppDelegate, league: League) {
        favouriteLeagueModel!.deleteLeagueFromCoredata(appDelegate: appDelegate, league: league)
    }
}
