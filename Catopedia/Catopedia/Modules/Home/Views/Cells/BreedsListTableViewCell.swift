//
//  BreedsListTableViewCell.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit
import Kingfisher

class BreedsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var energyLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupViews()
    }
    
    func setupViews() {
        self.breedImageView.layer.cornerRadius = 10.0
        self.containerView.layer.cornerRadius = 10.0
    }
    
    func setupData(breed: Breed) {
        self.breedImageView.kf.setImage(with: URL(string: breed.image?.url ?? ""))
        self.nameLabel.text = breed.name ?? ""
        self.originLabel.text = "Origin: \(breed.origin ?? "NA")"
        self.lifeSpanLabel.text = "Life-Span: \(breed.life_span ?? "NA")"
        self.weightLabel.text = "Weight(in metrics): \(breed.weight?.metric ?? "NA")"
        switch breed.energy_level ?? 0 {
        case 0..<3:
            self.energyLevelLabel.text = "Energy Level: 🥱"
            
        case 3:
            self.energyLevelLabel.text = "Energy Level: 🙃"
            
        default:
            self.energyLevelLabel.text = "Energy Level: 😃"
        }
    }
}
