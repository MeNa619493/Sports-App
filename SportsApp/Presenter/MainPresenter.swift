//
//  MainPresenter.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class MainPresenter: IMainPresenter {
    
    let iMainView: IMainView
    
    init(iMainView: IMainView) {
        self.iMainView = iMainView
    }
    
    func fetchData(endPoint: String) {
        let mainModel = MainModelController(iMainPresenter: self)
        mainModel.fetchDataFromApi(endPoint: endPoint)
    }
    
    func onSuccess(sports: Array<Sport>) {
        iMainView.renderMainView(sports: sports)
    }
    
    func onFail(error: Error) {
        iMainView.postErrorMainView(error: error)
    }
    
}
