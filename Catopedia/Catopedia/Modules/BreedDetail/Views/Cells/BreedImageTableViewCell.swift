//
//  BreedImageTableViewCell.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

class BreedImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var breedImageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func setupViews() {
        self.breedImageView.clipsToBounds = true
        self.breedImageView.layer.masksToBounds = true
        self.breedImageView.layer.cornerRadius = 12
    }
    
    func setupImageView(breedImage: BreedImage) {
        self.breedImageView.kf.setImage(with: URL(string: breedImage.url ?? ""))
        let aspectRatio: CGFloat =       CGFloat(breedImage.width ?? 0)/CGFloat(breedImage.height ?? 1)
        breedImageViewHeightConstraint.constant = self.breedImageView.frame.size.width*aspectRatio
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
