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
        
    var currentLeague: League?
    var upcomingEventsArray = Array<Event>()
    var latestResultsArray = Array<Event>()
    var teamsArray = Array<Team>()
    var leagueDetailsPresnter: ILeagueDetailsPresenter?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var favouriteLeaugeArray = Array<League>()
    
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerNibFiles()
        preparingViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         leagueDetailsPresnter = LeagueDetailsPresnter(leagueDetailsView: self)
        
        let newString = currentLeague?.strLeague!.withReplacedCharacters(" ", by: "%20")
        
        leagueDetailsPresnter?.fetchData(
            endPointUpcomingEvents: "eventsseason.php?id=4328&s=2022-2023",
            endPointLatestResults: "eventsseason.php?id=\(currentLeague?.idLeague ?? "4328")",
            endPointTeams: "search_all_teams.php?l=\(newString ?? "English%20Premier%20League")")
        
        leagueDetailsPresnter?.fetchFavouriteLeagues(appDelegate: appDelegate)
        checkFavouriteLeague()
    }
    
    func registerNibFiles() {
        upcomingEventsCollection.register(UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventsCell")
        
        latestResultsTable.register(UINib(nibName: "LatestResultTableViewCell", bundle: nil), forCellReuseIdentifier: "LatestResultsCell")
        
        teamsCollection.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
    }
    
    func preparingViews() {
        upcomingEventsCollection.showsHorizontalScrollIndicator = false
        latestResultsTable.showsVerticalScrollIndicator = false
        teamsCollection.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFavouriteButtonPressed(_ sender: Any) {
        
        if !currentLeague!.isFavourite {
            favouriteButton.image = UIImage(systemName: "heart.fill")
            print("save league to core data")
            currentLeague!.isFavourite = true
            leagueDetailsPresnter?.saveFavouriteLeauges(appDelegate: appDelegate, league: currentLeague!)
        } else {
            favouriteButton.image = UIImage(systemName: "heart")
            print("remove league from core data")
            leagueDetailsPresnter?.deleteLeagueFromCoredata(appDelegate: appDelegate, league: currentLeague!)
            currentLeague!.isFavourite = false
        }
    }
    
    func checkFavouriteLeague() {
        for item in favouriteLeaugeArray {
            if item.idLeague == currentLeague?.idLeague {
                favouriteButton.image = UIImage(systemName: "heart.fill")
                currentLeague?.isFavourite = true
            } else {
                favouriteButton.image = UIImage(systemName: "heart")
            }
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
    
    func DeliverFavouriteLeagues(leagues: Array<League>) {
        favouriteLeaugeArray = leagues
    }
}

extension String {
    func withReplacedCharacters(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}
