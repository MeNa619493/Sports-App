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
    
//    func fetchLeauges(endPoint: String, completion: @escaping ((Array<League>?, Error?) -> Void)) {
//        if let url = URL(string: UrlServices(endPoint: endPoint).url){
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data {
//                    let decodedJson: LeaguesResponse = convertFromJson(data: data) ?? LeaguesResponse(countries: Array<League>())
//
//                    completion(decodedJson.countries, nil)
//                }
//
//                if let error = error {
//                    completion(nil, error)
//                }
//            }.resume()
//        }
//    }
    
    func fetchLeauges(endPoint: String, completion: @escaping ((Array<League>?, Error?) -> Void)) {
        if let url = URL(string: UrlServices(endPoint: endPoint).url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let output = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                    print(output)
                    
                    let rawArray = output["countries"] as? Array<Dictionary<String,Any>> ?? Array<Dictionary<String,Any>>()
                    var leagueArray = Array<League>()
                    
                    for rawLeauges in rawArray {
                        var leauge = League()
                        leauge.idLeague = rawLeauges["idLeague"] as? String
                        leauge.strSport = rawLeauges["strSport"] as? String
                        leauge.strYoutube = rawLeauges["strYoutube"] as? String
                        leauge.strBadge = rawLeauges["strBadge"] as? String
                        leauge.strLeague = rawLeauges["strLeague"] as? String
                        leagueArray.append(leauge)
                    }
                    
                    completion(leagueArray, nil)
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
                    
                    let decodedJson: EventsResponse = convertFromJson(data: data) ?? EventsResponse(events: Array<Event>())
                    
                    completion(decodedJson.events, nil)
                }
                
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    func fetchLatestResults(endPoint: String, completion: @escaping ((Array<Event>?, Error?) -> Void)) {
        if let url = URL(string: UrlServices(endPoint: endPoint).url){
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data {
                    
                    let decodedJson: EventsResponse = convertFromJson(data: data) ?? EventsResponse(events: Array<Event>())
                    
                    completion(decodedJson.events, nil)
                }
                
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
    func fetchTeams(endPoint: String, completion: @escaping ((Array<Team>?, Error?) -> Void)) {
        if let url = URL(string: UrlServices(endPoint: endPoint).url){
            URLSession.shared.dataTask(with: url){ data, response, error in
                if let data = data {
                    
                    let decodedJson: TeamResponse = convertFromJson(data: data) ?? TeamResponse(teams: Array<Team>())
                    
                    completion(decodedJson.teams, nil)
                }
                
                if let error = error {
                    completion(nil, error)
                }
            }.resume()
        }
    }
    
}
    
    

