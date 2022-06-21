//
//  DatabaseManager.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class DatabaseManager: DatabaseService {
    let db = DBManager.sharedInstance
    
    func fetchFavouriteLeauges(appDelegate: AppDelegate, completion: @escaping ((Array<League>?) -> Void)) {
        
        completion(db.fetchData(appDelegate: appDelegate))
    }
    
    
    func saveFavouriteLeauges(appDelegate: AppDelegate, league: League) {
        db.addLeague(appDelegate: appDelegate, item: league)
    }
}
