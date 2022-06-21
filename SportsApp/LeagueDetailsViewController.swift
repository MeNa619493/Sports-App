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
    
    @IBOutlet weak var teamsCollection: UICollectionView! {
        didSet {
            teamsCollection.delegate = self
            teamsCollection.dataSource = self
        }
    }
        
    var league: League?
    var upcomingEventsArray = Array<Event>()
    var latestResultsArray = Array<Event>()
    var teamsArray = Array<Team>()
    
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        upcomingEventsCollection.register(UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventsCell")
        
        latestResultsTable.register(UINib(nibName: "LatestResultTableViewCell", bundle: nil), forCellReuseIdentifier: "LatestResultsCell")
        
        
        teamsCollection.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
        
        
        upcomingEventsCollection.showsHorizontalScrollIndicator = false
        latestResultsTable.showsVerticalScrollIndicator = false
        teamsCollection.showsHorizontalScrollIndicator = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let leagueDetailsPresnter: ILeagueDetailsPresenter = LeagueDetailsPresnter(leagueDetailsView: self)
        
        let newString = league?.strLeague!.withReplacedCharacters(" ", by: "%20")
        
        leagueDetailsPresnter.fetchData(
            endPointUpcomingEvents: "eventsseason.php?id=4328&s=2022-2023",
            endPointLatestResults: "eventsseason.php?id=\(league?.idLeague ?? "4328")",
            endPointTeams: "search_all_teams.php?l=\(newString ?? "English%20Premier%20League")")
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFavouriteButtonPressed(_ sender: Any) {
        
        if !league!.isFavourite {
            favouriteButton.image = UIImage(systemName: "heart.fill")
            print("save league to core data")
            league?.isFavourite = true
        } else {
            favouriteButton.image = UIImage(systemName: "heart")
            print("remove league from core data")
            league?.isFavourite = false
        }
        
    }
    
    
    
}

extension LeagueDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingEventsCollection:
            return upcomingEventsArray.count
        case teamsCollection:
            return teamsArray.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        
        switch collectionView {
        case upcomingEventsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCell", for: indexPath) as! UpcomingEventsCollectionViewCell
                
            cell.configureCell(upcomingEvent: upcomingEventsArray[indexPath.row])
            return cell
            
        case teamsCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCollectionViewCell
                
            cell.configureCell(imageUrl: teamsArray[indexPath.row].strTeamBadge ?? "no value")
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCollectionViewCell
                
            cell.configureCell(imageUrl: teamsArray[indexPath.row].strTeamBadge ?? "no value")
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: upcomingEventsCollection.frame.width, height: upcomingEventsCollection.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView ==  teamsCollection{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsVC") as! TeamDetailsViewController
            vc.modalPresentationStyle = .fullScreen
            vc.team = teamsArray[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }
        
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
        cell.configureCell(latestResult: latestResultsArray[indexPath.row])
        return cell
    }
    
//    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 80.0
//    }
    
}

extension LeagueDetailsViewController: ILeagueDetailsview {
    func renderUpcomingEventsView(upcomingEvents: Array<Event>) {
        self.upcomingEventsArray = upcomingEvents
        DispatchQueue.main.async {
            self.upcomingEventsCollection.reloadData()
        }
    }
    
    func renderLatestResultsView(latestResults: Array<Event>) {
        self.latestResultsArray = latestResults
        DispatchQueue.main.async {
            self.latestResultsTable.reloadData()
        }
    }
    
    func renderTeamsView(teams: Array<Team>) {
        self.teamsArray = teams
        DispatchQueue.main.async {
            self.teamsCollection.reloadData()
        }
    }
    
    
    func postErrorILeagueDetailsView(error: Error) {
        print(error.localizedDescription)
    }
}

extension String {
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}
