//
//  BreedsListingViewController.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import UIKit

class BreedsListingViewController: UIViewController {
    
    @IBOutlet weak var breedsListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialiseTableView()
    }
    
    func initialiseTableView() {
        breedsListTableView.register(UINib(nibName: "BreedsListTableViewCell", bundle: nil), forCellReuseIdentifier: "BreedsListTableViewCell")
        breedsListTableView.delegate = self
        breedsListTableView.dataSource = self
    }
}

extension BreedsListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
