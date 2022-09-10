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
                self?.breedsList.append(contentsOf: response)
                self?.pageCount += 1
            })
            .store(in: &subscriptions)
    }
}
