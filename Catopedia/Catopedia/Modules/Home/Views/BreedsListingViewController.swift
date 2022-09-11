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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UITextField!
    
    private var viewModel: BreedsListViewModel = BreedsListViewModel(networkManager: NetworkManager.sharedInstance)
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.initialiseTableView()
        self.bindViewModel()
        self.viewModel.fetchBreedsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initialiseTableView() {
        breedsListTableView.register(UINib(nibName: CellConstants.BreedsListTableViewCell, bundle: nil), forCellReuseIdentifier: CellConstants.BreedsListTableViewCell)
        breedsListTableView.delegate = self
        breedsListTableView.dataSource = self
    }
        
    func bindViewModel() {
        viewModel.$filteredResults
            .receive(on: RunLoop.main)
            .sink { [weak self] breedList in
                self?.breedsListTableView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if error != nil {
                    self?.showAlertForError(error: error)
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$shouldShowSpinner
            .receive(on: RunLoop.main)
            .sink { [weak self] shouldShowSpinner in
                if shouldShowSpinner {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
    
    func showAlertForError(error: Error?) {
        let alertController: UIAlertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true)
    }
}

extension BreedsListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: BreedsListTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellConstants.BreedsListTableViewCell, for: indexPath) as? BreedsListTableViewCell,
           indexPath.row < self.viewModel.filteredResults.count {
            cell.setupData(breed: self.viewModel.filteredResults[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.fetchDataIfNeeded(cellIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let breedDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreedDetailViewController") as? BreedDetailViewController {
            breedDetailVC.viewModel = BreedDetailViewModel(breed: self.viewModel.filteredResults[indexPath.row])
            self.navigationController?.pushViewController(breedDetailVC, animated: true)
        }
    }
}

extension BreedsListingViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var queryString = ""
        if range.length == 1 && string.count == 0 {
            queryString = String((textField.text ?? "").dropLast())
        }
        else {
            queryString = (textField.text ?? "").appending(string)
        }
        self.viewModel.searchBreed(queryString: queryString)
        return true
    }
}
