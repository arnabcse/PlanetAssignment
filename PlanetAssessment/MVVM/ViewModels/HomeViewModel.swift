//
//  HomeViewModel.swift
//  PlanetAssessment
//
//  Created by Arnab on 30/07/21.
//

import Foundation
import UIKit

class HomeViewModel: NSObject {

    var rotation_period: String?
    var name: String?
    var climate: String?
    var gravity: String?
    var terrain: String?
    var orbital_period: String?
    var diameter: String?
    var population: String?
    
    init(planet:PlanetModel){
        self.rotation_period = planet.rotation_period
        self.name = planet.name
        self.climate = planet.climate
        self.gravity = planet.gravity
        self.terrain = planet.terrain
        self.orbital_period = planet.orbital_period
        self.diameter = planet.diameter
        self.population = planet.population
    }
}
