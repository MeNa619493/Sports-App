//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation

class NetworkManager: ApiService {
    func fetchSports(endPoint: String, completion: @escaping ((Array<Sport>?, Error?) -> Void)) {
        
        if let  url = URL(string: UrlServices(endPoint: endPoint).url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodedjson: SportsResponse = convertFromJson(data: data) ?? SportsResponse(sports: Array<Sport>())
                    
                    completion(decodedjson.sports,nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }

    }
    
}
    
    

