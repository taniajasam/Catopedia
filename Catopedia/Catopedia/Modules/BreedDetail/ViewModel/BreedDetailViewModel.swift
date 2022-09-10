//
//  BreedDetailViewModel.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import Foundation

class BreedDetailViewModel {
    var breed: Breed?
    
    init(breed: Breed) {
        self.breed = breed
    }
    
    func getNumberOfItems() -> Int {
        return 2
    }
}
