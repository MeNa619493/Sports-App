//
//  MainCollectionViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit
import Reachability

class MainCollectionViewController: UICollectionViewController {
    var sportsArray = Array<Sport>()
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibFile()
        
        let mainPresnter: IMainPresenter = MainPresenter(iMainView: self)
        
        reachability.whenReachable = { _ in
            mainPresnter.fetchData(endPoint: "all_sports.php")
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
    
    func registerNibFile() {
        self.collectionView!.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mainCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability.stopNotifier()
    }
    
    func showAlertNotConnected() {
        let alert = UIAlertController(title: "Not Connected!", message: "Please, Check the internet connection.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        
        // Configure the cell
        cell.configureMainCell(sport: sportsArray[indexPath.row])
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let widthSize = (self.collectionView.frame.size.width) / 2
        return CGSize(width: widthSize, height: widthSize)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let LeagueVC = self.storyboard?.instantiateViewController(identifier: "LeaguesVC") as! LeaguesTableViewController
        LeagueVC.sport = sportsArray[indexPath.row].strSport
        self.navigationController?.pushViewController(LeagueVC, animated: true)
    }

}

extension MainCollectionViewController: IMainView {
    
    func renderMainView(sports: Array<Sport>) {
        self.sportsArray = sports
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func postErrorMainView(error: Error) {
        print(error.localizedDescription)
    }
}

