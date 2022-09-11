//
//  BreedDetailViewController.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

enum BreedDetailSection: Int {
    case image
    case description
}

class BreedDetailViewController: UIViewController {
    
    @IBOutlet weak var breedDetailTableView: UITableView!
    
    var viewModel: BreedDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialiseTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.tintColor = .black
        self.title = self.viewModel?.breed?.name ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initialiseTableView() {
        breedDetailTableView.register(UINib(nibName: CellConstants.BreedImageTableViewCell, bundle: nil), forCellReuseIdentifier: CellConstants.BreedImageTableViewCell)
        breedDetailTableView.register(UINib(nibName: CellConstants.BreedDescriptionTableViewCell, bundle: nil), forCellReuseIdentifier: CellConstants.BreedDescriptionTableViewCell)
        breedDetailTableView.delegate = self
        breedDetailTableView.dataSource = self
    }
}

extension BreedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let breedDetailSection: BreedDetailSection = BreedDetailSection(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch breedDetailSection {
        case .image:
            if let cell: BreedImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellConstants.BreedImageTableViewCell, for: indexPath) as? BreedImageTableViewCell {
                cell.setupImageView(breedImage: self.viewModel?.breed?.image)
                self.view.backgroundColor = cell.breedImageView.image?.averageColor
                return cell
            }
            return UITableViewCell()
            
        case .description:
            if let cell: BreedDescriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellConstants.BreedDescriptionTableViewCell, for: indexPath) as? BreedDescriptionTableViewCell {
                cell.setupData(breed: self.viewModel?.breed)
                cell.delegate = self
                return cell
            }
            return UITableViewCell()
        }
    }
}

extension BreedDetailViewController: BreedDescriptionTableViewCellDelegate {
    func urlClicked(url: URL) {
        UIApplication.shared.open(url)
    }
}
