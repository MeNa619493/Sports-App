//
//  FavouritesViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import ProgressHUD

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesTable: UITableView! {
        didSet {
            favouritesTable.delegate = self
            favouritesTable.dataSource = self
        }
    }
    
    var favouriteLeagues = Array<League>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var presenter: IFavouriteLeaguePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibFile()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showprogress()
        presenter = FavouriteLeaguePresenter(favouriteLeagueView: self)
        presenter?.fetchData(appDelegate: appDelegate)
    }


    func setupView() {
        self.favouritesTable.separatorStyle = .none
        self.favouritesTable.showsVerticalScrollIndicator = false
    }

    func registerNibFile() {
        self.favouritesTable!.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
    }

    func showprogress() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.show()
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

        cell.delegate = self
        cell.configureLeaugeCell(league: favouriteLeagues[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.currentLeague = favouriteLeagues[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row != 0 {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.presenter?.deleteLeagueFromCoredata(appDelegate: self.appDelegate, league: favouriteLeagues[indexPath.row])
            favouriteLeagues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
}

extension FavouritesViewController: IFavouriteLeagueView {
    func renderFavouriteLeagueView(leagues: Array<League>) {
        favouriteLeagues = leagues
        DispatchQueue.main.async {
            self.favouritesTable.reloadData()
            ProgressHUD.dismiss()
        }
    }
}

extension FavouritesViewController: LeagueView {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}









