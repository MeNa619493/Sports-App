//
//  MainCollectionViewController.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/18/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    var sportsArray = Array<Sport>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mainCell")
        
        let mainPresnter: IMainPresenter = MainPresenter(iMainView: self)
        mainPresnter.fetchData(endPoint: "all_sports.php")

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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

