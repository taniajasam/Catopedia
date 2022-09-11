//
//  CatopediaTests.swift
//  CatopediaTests
//
//  Created by Tania Jasam on 10/09/22.
//

import XCTest
import Combine
@testable import Catopedia

class CatopediaTests: XCTestCase {
    var sut: BreedsListViewModel?
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "BreedsTestData", ofType: "json")
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) {
            sut = BreedsListViewModel(networkManager: FakeNetworkManager(fakeData: data))
        }
    }
    
    func testNumberOfItems() {
        sut?.fetchBreedsList()
        let numberOfItems = sut?.getNumberOfItems()
        XCTAssertEqual(10, numberOfItems, "Number of items should be 10")
    }

    func testSearchSuccess() {
        sut?.fetchBreedsList()
        sut?.searchBreed(queryString: "Abys")
        let numberOfItems = sut?.getNumberOfItems()
        XCTAssertEqual(1, numberOfItems, "Number of items should be 1")
    }
    
    func testSearchFailure() {
        sut?.fetchBreedsList()
        sut?.searchBreed(queryString: "huj")
        let numberOfItems = sut?.getNumberOfItems()
        XCTAssertEqual(0, numberOfItems, "Number of items should be 0")
    }
}

class FakeNetworkManager: NetworkRequestable {
    
    var fakeData: Data
    
    init(fakeData: Data) {
        self.fakeData = fakeData
    }
    
    func dataTask<T>(with requestConfig: RequestConfiguration, type: T.Type) -> Future<[T], Error> where T : Decodable {
        return Future<[T], Error> { [weak self] promise in
            guard let self = self else { return promise(.failure(NetworkError.unknown))}
            
            let decoder: JSONDecoder = JSONDecoder()
            if let fakeResponse = try? decoder.decode([T].self, from: self.fakeData) {
                promise(.success(fakeResponse))
            } else {
                promise(.failure(NetworkError.unknown))
            }
        }
    }
}
