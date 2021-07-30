//
//  PlanetListViewController.swift
//  PlanetAssessment
//
//  Created by Arnab on 29/07/21.
//

import UIKit
import CoreData

class PlanetListViewController: UITableViewController {
    
    var planetList = [NSManagedObject]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 126
        self.tableView.rowHeight = UITableView.automaticDimension

        self.title = "Planets"
        self.tableView.dataSource = self
        self.initializeFetchedResultsController()
    }
    
    func initializeFetchedResultsController() {
        let managedContext = CoreDataStorage.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        do {
            let results = try managedContext().fetch(fetchRequest)
            planetList = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch planetrecords. \(error), \(error.userInfo)")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as! PlanetCell
        let planetlist = planetList[indexPath.row]
        cell.rotation_periodLabel.text = planetlist.value(forKey: "rotation_period") as? String
        cell.nameOfPlanetLabel.text = planetlist.value(forKey: "name") as? String
        cell.climateLabel.text = planetlist.value(forKey: "climate") as? String
        cell.gravityLabel.text = planetlist.value(forKey: "gravity") as? String
        cell.terrainLabel.text = planetlist.value(forKey: "terrain") as? String
        cell.orbital_periodLabel.text = planetlist.value(forKey: "orbital_period") as? String
        cell.diameterLabel.text = planetlist.value(forKey: "diameter") as? String
        cell.populationLabel.text = planetlist.value(forKey: "population") as? String
        return cell
    }
    
}

