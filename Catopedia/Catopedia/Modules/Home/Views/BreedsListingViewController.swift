//
//  BreedsListingViewController.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit
import Combine

class BreedsListingViewController: UIViewController {
    
    @IBOutlet weak var breedsListTableView: UITableView!
    
    private var viewModel: BreedsListViewModel = BreedsListViewModel(networkManager: NetworkManager.sharedInstance)
    var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialiseTableView()
        self.bindViewModel()
        self.viewModel.fetchBreedsList()
    }
    
    func initialiseTableView() {
        breedsListTableView.register(UINib(nibName: "BreedsListTableViewCell", bundle: nil), forCellReuseIdentifier: "BreedsListTableViewCell")
        breedsListTableView.delegate = self
        breedsListTableView.dataSource = self
//        breedsListTableView.rowHeight = UITableView.automaticDimension
    }
        
    func bindViewModel() {
        viewModel.$breedsList
            .receive(on: RunLoop.main)
            .sink { [weak self] breedList in
                if breedList.isEmpty {
                    
                } else {
                    self?.breedsListTableView.reloadData()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if error != nil {
                    // show alert
                }
            }
            .store(in: &subscriptions)
    }
}

extension BreedsListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: BreedsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BreedsListTableViewCell", for: indexPath) as? BreedsListTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.fetchDataIfNeeded(cellIndex: indexPath.row)
    }
}
