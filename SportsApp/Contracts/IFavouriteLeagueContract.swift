//
//  IFavouriteLeagueContract.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol IFavouriteLeagueView {
    func renderFavouriteLeagueView(leagues: Array<League>)
}

protocol IFavouriteLeaguePresenter {
    func fetchData(appDelegate: AppDelegate)
    func onSuccess(leagues: Array<League>)
}

protocol IFavouriteLeagueModel {
    func fetchDataFromCoredata(appDelegate: AppDelegate)
}
