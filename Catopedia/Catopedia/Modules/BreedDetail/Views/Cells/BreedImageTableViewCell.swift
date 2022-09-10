//
//  BreedImageTableViewCell.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

class BreedImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func setupViews() {
        self.breedImageView.clipsToBounds = true
        self.breedImageView.layer.masksToBounds = true
        self.breedImageView.layer.cornerRadius = 12
    }
    
    func setupImageView(imageURL: String) {
        self.breedImageView.kf.setImage(with: URL(string: imageURL))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
