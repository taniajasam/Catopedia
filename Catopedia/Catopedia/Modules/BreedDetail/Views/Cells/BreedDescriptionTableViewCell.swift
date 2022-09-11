//
//  BreedDescriptionTableViewCell.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

protocol BreedDescriptionTableViewCellDelegate: AnyObject {
    func urlClicked(url: URL)
}

class BreedDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var breedDescriptionLabel: UILabel!
    @IBOutlet weak var breedContainerView: UIView!
    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var knowMoreLabel: UILabel!
    
    weak var delegate: BreedDescriptionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
    
    func setupViews() {
        self.urlTextView.delegate = self
        breedContainerView.clipsToBounds = true
        breedContainerView.layer.cornerRadius = 10
        breedContainerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func setupData(breed: Breed?) {
        if let breed = breed {
            nameLabel.text = breed.name ?? ""
            originLabel.text = "Origin: \(breed.origin ?? "NA")"
            breedDescriptionLabel.text = breed.breedDescription ?? "Description: NA"
            if let url = breed.wikipedia_url, !url.isEmpty {
                urlTextView.text = url
                knowMoreLabel.isHidden = false
            } else {
                urlTextView.isHidden = true
                knowMoreLabel.isHidden = true
            }
        }
    }
}

extension BreedDescriptionTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        self.delegate?.urlClicked(url: URL)
        return true
    }
}
