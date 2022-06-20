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
                    let decodedJson: SportsResponse = convertFromJson(data: data) ?? SportsResponse(sports: Array<Sport>())
                    
                    completion(decodedJson.sports, nil)
                }
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }

    }
    
    func fetchLeauges(endPoint: String, completion: @escaping ((Array<League>?, Error?) -> Void)) {
        if let url = URL(string: UrlServices(endPoint: endPoint).url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decodedJson: LeaguesResponse = convertFromJson(data: data) ?? LeaguesResponse(countries: Array<League>())
                    
                    completion(decodedJson.countries, nil)
                }
                
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    func fetchUpcomingEvents(endPoint: String, completion: @escaping ((Array<Event>?, Error?) -> Void)) {
        if let url = URL(string: UrlServices(endPoint: endPoint).url){
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data {
                    
                    let decodedJson: UpcomingEventsResponse = convertFromJson(data: data) ?? UpcomingEventsResponse(events: Array<Event>())
                    
                    completion(decodedJson.events, nil)
                }
                
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
}
    
    

