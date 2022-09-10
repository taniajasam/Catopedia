//
//  BreedsListingViewModel.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import Foundation
import Combine

class BreedsListViewModel: ObservableObject {
    lazy var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    var networkManager: NetworkRequestable?
    
    @Published var breedsList: [Breed] = []
    @Published var error: Error?
    
    let pageSize: Int = 10
    var pageCount: Int = 0
    
    init(networkManager: NetworkRequestable) {
        self.networkManager = networkManager
    }
    
    func fetchBreedsList() {
        networkManager?.dataTask(with: BreedsListAPIConfiguration(pageSize: pageSize, pageCount: pageCount), type: Breed.self)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                
                default:
                    break
                }
            }, receiveValue: { [weak self] response in
                if response.isEmpty {
                    /// To restrict the next page call
                    self?.pageCount = -1
                } else {
                    self?.breedsList.append(contentsOf: response)
                    self?.pageCount += 1
                }
            })
            .store(in: &subscriptions)
    }
    
    func getNumberOfItems() -> Int {
        self.breedsList.count 
    }
    
    func fetchDataIfNeeded(cellIndex: Int) {
        /// Ideally we would be getting totalPages or identifier in some API response and then pageCount (-1) condition won't be required
        if self.breedsList.count - 5 < cellIndex, self.pageCount != -1 {
            self.fetchBreedsList()
        }
    }
}
