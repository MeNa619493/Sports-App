//
//  ApiServices.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

protocol ApiService {
    func fetchSports(endPoint: String, completion: @escaping ((Array<Sport>?, Error?) -> Void))
    
    func fetchLeauges(endPoint: String, completion: @escaping ((Array<League>?, Error?) -> Void))
}
