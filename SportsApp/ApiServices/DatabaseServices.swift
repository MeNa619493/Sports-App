//
//  DatabaseServices.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol DatabaseService {
    
    func fetchFavouriteLeauges(appDelegate: AppDelegate, completion: @escaping ((Array<League>?) -> Void))
    
    func saveFavouriteLeauges(appDelegate: AppDelegate, league: League)
    
}
