//
//  PlanetCell.swift
//  PlanetAssessment
//
//  Created by Arnab on 29/07/21.
//

import UIKit

class PlanetCell: UITableViewCell {
    @IBOutlet weak var rotation_periodLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var orbital_periodLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var nameOfPlanetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
