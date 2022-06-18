//
//  MainModelController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class MainModelController: IMainModel {
    
    let networkManager: ApiService = NetworkManager()
    let iMainPresenter: IMainPresenter
    
    init(iMainPresenter: IMainPresenter)  {
        self.iMainPresenter = iMainPresenter
    }
    
    func fetchDataFromApi(endPoint: String) {
        networkManager.fetchSports(endPoint: endPoint) { sports, error in
            
            if let sports = sports {
                self.iMainPresenter.onSuccess(sports: sports)
            }
            
            if let error = error {
                self.iMainPresenter.onFail(error: error)
            }
        }
    }
    
    
}
