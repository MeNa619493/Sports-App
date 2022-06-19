//
//  ILeagueContract.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/19/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol ILeagueView { // For home View
    func renderLeagueView(leagues: Array<League>)
    func postErrorLeagueView(error: Error)
}

protocol ILeaguePresenter {  // For Presenter
    func fetchData(endPoint: String)
    func onSuccess(leagues: Array<League>)
    func onFail(error: Error)
}

protocol ILeagueModel { // For Model
    func fetchDataFromApi(endPoint: String)
}
