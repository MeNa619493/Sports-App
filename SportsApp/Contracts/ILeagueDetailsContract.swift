//
//  ILeagueDetailsContract.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/20/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol ILeagueDetailsview {
    func renderLeagueDetailsView(events: Array<Event>)
    func postErrorILeagueDetailsView(error: Error)
}

protocol ILeagueDetailsPresenter {
    func fetchData(endPoint: String)
    func onSuccess(events: Array<Event>)
    func onFail(error: Error)
}

protocol ILeagueDetailsModel { 
    func fetchDataFromApi(endPoint: String)
}
