//
//  PlanetModel.swift
//  PlanetAssessment
//
//  Created by Arnab on 30/07/21.
//

import UIKit

class PlanetModel: Decodable {
    var rotation_period: String?
    var name: String?
    var climate: String?
    var gravity: String?
    var terrain: String?
    var orbital_period: String?
    var diameter: String?
    var population: String?
    
    init(rotation_period:String, name:String, climate: String, gravity: String, terrain: String, orbital_period: String, diameter: String, population: String){
        self.rotation_period = rotation_period
        self.name = name
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.orbital_period = orbital_period
        self.diameter = diameter
        self.population = population
    }
}


class PlanetResultModel: Decodable {
    var results = [PlanetModel]()
    init(results: [PlanetModel]) {
        self.results = results
    }
}
