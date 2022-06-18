//
//  IMainContract.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol IMainView { // For home View
    func renderMainView(sports: Array<Sport>)
    func postErrorMainView(error: Error)
}

protocol IMainPresenter {  // For Presenter
    func fetchData(endPoint: String)
    func onSuccess(sports: Array<Sport>)
    func onFail(error: Error)
}

protocol IMainModel { // For Model
    func fetchDataFromApi(endPoint: String)
}
