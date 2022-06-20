//
//  ViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var upcomingEventsCollection: UICollectionView! {
        didSet {
            upcomingEventsCollection.delegate = self
            upcomingEventsCollection.dataSource = self
        }
    }
    
    @IBOutlet weak var latestResultsTable: UITableView! {
        didSet {
            latestResultsTable.delegate = self
            latestResultsTable.dataSource = self
        }
    }
    
    @IBOutlet weak var teamsCollection: UICollectionView!
    
    var upcomingEventsArray = Array<Event>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        upcomingEventsCollection.register(UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventsCell")
        
        latestResultsTable.register(UINib(nibName: "LatestResultTableViewCell", bundle: nil), forCellReuseIdentifier: "LatestResultsCell")
        
        let leagueDetailsPresnter: ILeagueDetailsPresenter = LeagueDetailsPresnter(leagueDetailsView: self)
        leagueDetailsPresnter.fetchData(endPoint: "eventsseason.php?id=4328")
        
    }
}

extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        upcomingEventsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            
            // Configure the cell
        cell.configureCell(
            imageUrl: upcomingEventsArray[indexPath.row].strThumb ?? "no value",
            teamsName: upcomingEventsArray[indexPath.row].strEvent ?? "no value",
            date: upcomingEventsArray[indexPath.row].dateEvent ?? "no value",
            hour: upcomingEventsArray[indexPath.row].strTime ?? "no value")
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: upcomingEventsCollection.frame.width, height: upcomingEventsCollection.frame.height)
    }
}

extension LeagueDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingEventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LatestResultsCell", for: indexPath) as! LatestResultTableViewCell

        // Configure the cell...
        cell.makeCellRounded()
        cell.configureCell(
            homeTeam: upcomingEventsArray[indexPath.row].strHomeTeam ?? "no value",
            awayTeam: upcomingEventsArray[indexPath.row].strAwayTeam ?? "no value",
            homeScore: upcomingEventsArray[indexPath.row].intHomeScore ?? "no value",
            awayScore: upcomingEventsArray[indexPath.row].intAwayScore ?? "no value")
        
        return cell
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
}

extension LeagueDetailsViewController: ILeagueDetailsview {
    func renderLeagueDetailsView(events: Array<Event>) {
        self.upcomingEventsArray = events
        DispatchQueue.main.async {
            self.upcomingEventsCollection.reloadData()
            self.latestResultsTable.reloadData()
        }
    }
    
    func postErrorILeagueDetailsView(error: Error) {
        print(error.localizedDescription)
    }
}

