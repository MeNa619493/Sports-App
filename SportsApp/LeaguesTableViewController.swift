//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class LeaguesTableViewController: UITableViewController {
    
    var leaguesArray = Array<League>()
    var sport:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView!.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        
        let leaguePresenter: ILeaguePresenter = LeaguePresenter(leagueView: self)
        if let sport = sport {
            leaguePresenter.fetchData(endPoint: "search_all_leagues.php?s=\(sport)")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell

        // Configure the cell...
        cell.configureLeaugeCell(league: leaguesArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //LeagueDetailsVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.currentLeague = leaguesArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension LeaguesTableViewController: ILeagueView{
    func renderLeagueView(leagues: Array<League>) {
        self.leaguesArray = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func postErrorLeagueView(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
