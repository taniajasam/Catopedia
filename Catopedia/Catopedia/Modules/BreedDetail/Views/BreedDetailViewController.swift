//
//  BreedDetailViewController.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

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
        breedDetailTableView.register(UINib(nibName: "BreedImageTableViewCell", bundle: nil), forCellReuseIdentifier: "BreedImageTableViewCell")
        breedDetailTableView.register(UINib(nibName: "BreedDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "BreedDescriptionTableViewCell")
        breedDetailTableView.delegate = self
        breedDetailTableView.dataSource = self
    }
}

extension BreedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell: BreedImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BreedImageTableViewCell", for: indexPath) as? BreedImageTableViewCell {
                cell.setupImageView(breedImage: self.viewModel?.breed?.image)
                self.view.backgroundColor = cell.breedImageView.image?.averageColor
                return cell
            }
            
        case 1:
            if let cell: BreedDescriptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BreedDescriptionTableViewCell", for: indexPath) as? BreedDescriptionTableViewCell {
                cell.setupData(breed: self.viewModel?.breed)
                cell.delegate = self
                return cell
            }
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension BreedDetailViewController: BreedDescriptionTableViewCellDelegate {
    func urlClicked(url: URL) {
        UIApplication.shared.open(url)
    }
}
