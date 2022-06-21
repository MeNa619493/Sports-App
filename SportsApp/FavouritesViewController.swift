//
//  FavouritesViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesTable: UITableView! {
        didSet {
            favouritesTable.delegate = self
            favouritesTable.dataSource = self
        }
    }
    
    var favouriteLeagues = Array<League>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.favouritesTable!.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        
        self.favouritesTable.separatorStyle = .none
        self.favouritesTable.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let presenter: IFavouriteLeaguePresenter = FavouriteLeaguePresenter(favouriteLeagueView: self)
        presenter.fetchData(appDelegate: appDelegate)
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell

        // Configure the cell...
        cell.configureLeaugeCell(league: favouriteLeagues[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //LeagueDetailsVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.league = favouriteLeagues[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
}

extension FavouritesViewController: IFavouriteLeagueView {
    func renderFavouriteLeagueView(leagues: Array<League>) {
        favouriteLeagues = leagues
        DispatchQueue.main.async {
            self.favouritesTable.reloadData()
        }
    }
}









