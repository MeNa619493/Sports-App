//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Reachability
import ProgressHUD

class LeaguesTableViewController: UITableViewController {
    
    var leaguesArray = Array<League>()
    var sport:String?
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibFile()
        showprogress()
        setupView()
        
        let leaguePresenter: ILeaguePresenter = LeaguePresenter(leagueView: self)
        
        reachability.whenReachable = { _ in
            if let sport = self.sport {
                leaguePresenter.fetchData(endPoint: "search_all_leagues.php?s=\(sport)")
            }
        }
        
        reachability.whenUnreachable = { _ in
            self.showAlertNotConnected()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability.stopNotifier()
    }
    
    func setupView() {
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
    }
    
    func registerNibFile() {
        self.tableView!.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
    }
    
    func showprogress() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
    }
    
    func showAlertNotConnected() {
        let alert = UIAlertController(title: "Not Connected!", message: "Please, Check the internet connection.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell

        // Configure the cell...
        cell.delegate = self
        cell.configureLeaugeCell(league: leaguesArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
            ProgressHUD.dismiss()
        }
    }
    
    func postErrorLeagueView(error: Error) {
        print(error.localizedDescription)
    }
}

extension LeaguesTableViewController: LeagueView {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
