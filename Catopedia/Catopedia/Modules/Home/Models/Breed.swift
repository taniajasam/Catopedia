//
//  Breed.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import Foundation

struct Breed: Decodable {
    var weight: BreedWeight?
    var id: String?
    var name: String?
    var temperament: String?
    var origin: String?
    var breedDescription: String?
    var life_span: String?
    var energy_level: Int?
    var alt_names: String?
    var image: BreedImage?
    var wikipedia_url: String?
    
    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case temperament
        case origin
        case breedDescription = "description"
        case life_span
        case energy_level
        case alt_names
        case image
        case wikipedia_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weight = try container.decodeIfPresent(BreedWeight.self, forKey: .weight)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        temperament = try container.decodeIfPresent(String.self, forKey: .temperament)
        origin = try container.decodeIfPresent(String.self, forKey: .origin)
        breedDescription = try container.decodeIfPresent(String.self, forKey: .breedDescription)
        life_span = try container.decodeIfPresent(String.self, forKey: .life_span)
        energy_level = try container.decodeIfPresent(Int.self, forKey: .energy_level)
        alt_names = try container.decodeIfPresent(String.self, forKey: .alt_names)
        image = try container.decodeIfPresent(BreedImage.self, forKey: .image)
        wikipedia_url = try container.decodeIfPresent(String.self, forKey: .wikipedia_url)
    }
}

struct BreedWeight: Decodable {
    var imperial: String?
    var metric: String?
}

struct BreedImage: Decodable {
    var id: String?
    var width: Int?
    var height: Int?
    var url: String?
}
