//
//  BreedsListingViewModel.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import Foundation
import Combine

class BreedsListViewModel: ObservableObject {
    private lazy var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    private var networkManager: NetworkRequestable?
    private var breedsList: [Breed] = []
    
    @Published var error: Error?
    @Published var filteredResults: [Breed] = []
    @Published var shouldShowSpinner: Bool = false
    
    private let pageSize: Int = 10
    private var pageCount: Int = 0
    private var isPaginationCallInProgress: Bool = false
    
    init(networkManager: NetworkRequestable) {
        self.networkManager = networkManager
    }
    
    /// Calls network manager to fetch the data for provided page count with given page size.
    func fetchBreedsList() {
        shouldShowSpinner = true
        networkManager?.dataTask(with: BreedsListAPIConfiguration(pageSize: pageSize, pageCount: pageCount), type: Breed.self)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isPaginationCallInProgress = false
                self?.shouldShowSpinner = false
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
                    self?.filteredResults = (self?.breedsList)!
                    self?.pageCount += 1
                }
            })
            .store(in: &subscriptions)
    }
    
    /// Returns number of rows for the breed list.
    /// - Returns: count for the breeds to be shown in the list.
    func getNumberOfItems() -> Int {
        self.filteredResults.count
    }
    
    /// This method calls makes the API call based on following conditions.
    /// - Remaining cells is less than 5
    /// - There are more pages to be fetched (this is being checked by page count as -1). Ideally, we would get total pages through API response.
    /// - Next page should not be called when search is being done.
    /// - Next page should not be called while previous pagination call is in progress.
    /// - Parameter cellIndex: Index of the cell while scrolling (willDisplayCell)
    func fetchDataIfNeeded(cellIndex: Int) {
        if self.filteredResults.count - 5 < cellIndex,
           self.pageCount != -1,
           filteredResults.count == breedsList.count,
           isPaginationCallInProgress == false {
            self.fetchBreedsList()
            self.isPaginationCallInProgress = true
        }
    }
    
    /// This method performs search on the available data (it does not make an API call to search API).
    /// - Parameter queryString: string to be searched.
    func searchBreed(queryString: String) {
        if queryString.isEmpty {
            filteredResults = breedsList
        } else {
            filteredResults = breedsList.filter({ breed in
                guard let breedName = breed.name else { return false}
                return breedName.lowercased().contains(queryString.lowercased())
            })
        }
    }
}
