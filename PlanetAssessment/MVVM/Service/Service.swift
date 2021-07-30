//
//  Service.swift
//  PlanetAssessment
//
//  Created by Arnab on 30/07/21.
//

import UIKit
import CoreData

class Service: NSObject {
    
    static let shareInstance = Service()
    var planetModelData = [PlanetModel]()
    
    func getAllPlanetData(completion: @escaping([PlanetModel]?, Error?) -> ()){
        let urlString = "https://swapi.dev/api/planets/"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    let results = try JSONDecoder().decode(PlanetResultModel.self, from: data)
                    for planet in results.results{
                        self.planetModelData.append(PlanetModel(rotation_period: planet.rotation_period!, name: planet.name!, climate: planet.climate!, gravity: planet.gravity!, terrain: planet.terrain!, orbital_period: planet.orbital_period!, diameter: planet.diameter!, population: planet.population!))
                        self.saveDataToStore(rotation_period: planet.rotation_period!, name: planet.name!, climate: planet.climate!, gravity: planet.gravity!, terrain: planet.terrain!, orbital_period: planet.orbital_period!, diameter: planet.diameter!, population: planet.population!)
                    }
                    completion(self.planetModelData, nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func saveDataToStore(rotation_period:String, name:String, climate: String, gravity: String, terrain: String, orbital_period: String, diameter: String, population: String){
        let context = CoreDataStorage.shared.managedObjectContext()
        let newPlanet = NSEntityDescription.insertNewObject(forEntityName: "Planet", into: context)
        do {
            newPlanet.setValue(rotation_period, forKey: "rotation_period")
            newPlanet.setValue(name, forKey: "name")
            newPlanet.setValue(climate, forKey: "climate")
            newPlanet.setValue(gravity, forKey: "gravity")
            newPlanet.setValue(terrain, forKey: "terrain")
            newPlanet.setValue(orbital_period, forKey: "orbital_period")
            newPlanet.setValue(diameter, forKey: "diameter")
            newPlanet.setValue(population, forKey: "population")
            try context.save()
        } catch {
            //do nothing
        }
    }
}
