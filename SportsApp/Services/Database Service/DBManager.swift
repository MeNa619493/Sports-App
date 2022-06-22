//
//  DBManager.swift
//  SportsApp
//
//  Created by Mina Ezzat on 6/21/22.
//  Copyright © 2022 Mina Ezzat. All rights reserved.
//

import Foundation
import CoreData

class DBManager{
    static let sharedInstance = DBManager()
    
    private init(){}

    func addLeague(appDelegate: AppDelegate, item: League){

        let managedContext = appDelegate.persistentContainer.viewContext

        if let entity = NSEntityDescription.entity(forEntityName: "Model", in: managedContext){
            
            let league = NSManagedObject(entity: entity, insertInto: managedContext)
            league.setValue(item.idLeague, forKey: "idLeague")
            league.setValue(item.strSport, forKey: "strSport")
            league.setValue(item.strYoutube, forKey: "strYoutube")
            league.setValue(item.strBadge, forKey: "strBadge")
            league.setValue(item.strLeague, forKey: "strLeague")
            league.setValue(item.isFavourite, forKey: "isFavourite")

            do {
                try managedContext.save()
                print("leagues saved in coredata")
            }catch let error as NSError {
                print("Error in saving")
                print(error.localizedDescription)
            }
        }
    }

    func fetchData(appDelegate: AppDelegate) -> Array<League>{

        var fetchedList : Array<Model> = Array<Model>()
        var castedList : Array<League> = Array<League>()
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")

        do{
            fetchedList = try managedContext.fetch(fetchRequest) as! Array<Model>
            for item in fetchedList {
                var leauge = League()
                leauge.idLeague = item.value(forKey: "idLeague") as? String
                leauge.strSport = item.value(forKey: "strSport") as? String
                leauge.strYoutube = item.value(forKey: "strYoutube") as? String
                leauge.strBadge = item.value(forKey: "strBadge") as? String
                leauge.strLeague = item.value(forKey: "strLeague") as? String
                leauge.isFavourite = item.value(forKey: "isFavourite") as! Bool
                castedList.append(leauge)
            }

            print("retreve data")
        }catch let error as NSError {
            print("Error in retreving")
            print(error.localizedDescription)
        }

        return castedList
    }
    
    func deleteLeagueFromFavourites(appDelegate: AppDelegate, item: League){
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Model")
            fetchRequest.predicate = NSPredicate(format: "idLeague == %@", item.idLeague!)
            let league = try managedContext.fetch(fetchRequest)
        
            managedContext.delete((league as! [NSManagedObject]).first!)
        
            try managedContext.save()
            print("league deleted")
            
        } catch let error as NSError{
            print("Error in deleting")
            print(error.localizedDescription)
        }
    }
    

}



