//
//  BreedDescriptionTableViewCell.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

class BreedDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var breedDescriptionLabel: UILabel!
    @IBOutlet weak var wikipediaLabel: UILabel!
    @IBOutlet weak var breedContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(breed: Breed) {
        nameLabel.text = breed.name ?? ""
        originLabel.text = "Origin: \(breed.origin ?? "NA")"
        breedDescriptionLabel.text = breed.breedDescription ?? "Description: NA"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
