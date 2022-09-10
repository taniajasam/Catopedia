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

//{
//        "weight": {
//            "imperial": "6 - 12",
//            "metric": "3 - 5"
//        },
//        "id": "soma",
//        "name": "Somali",
//        "cfa_url": "http://cfa.org/Breeds/BreedsSthruT/Somali.aspx",
//        "vetstreet_url": "http://www.vetstreet.com/cats/somali",
//        "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/somali",
//        "temperament": "Mischievous, Tenacious, Intelligent, Affectionate, Gentle, Interactive, Loyal",
//        "origin": "Somalia",
//        "country_codes": "SO",
//        "country_code": "SO",
//        "description": "The Somali lives life to the fullest. He climbs higher, jumps farther, plays harder. Nothing escapes the notice of this highly intelligent and inquisitive cat. Somalis love the company of humans and other animals.",
//        "life_span": "12 - 16",
//        "indoor": 0,
//        "alt_names": "Fox Cat, Long-Haired Abyssinian",
//        "adaptability": 5,
//        "affection_level": 5,
//        "child_friendly": 3,
//        "dog_friendly": 4,
//        "energy_level": 5,
//        "grooming": 3,
//        "health_issues": 2,
//        "intelligence": 5,
//        "shedding_level": 4,
//        "social_needs": 5,
//        "stranger_friendly": 5,
//        "vocalisation": 1,
//        "experimental": 0,
//        "hairless": 0,
//        "natural": 0,
//        "rare": 0,
//        "rex": 0,
//        "suppressed_tail": 0,
//        "short_legs": 0,
//        "wikipedia_url": "https://en.wikipedia.org/wiki/Somali_(cat)",
//        "hypoallergenic": 0,
//        "reference_image_id": "EPF2ejNS0",
//        "image": {
//            "id": "EPF2ejNS0",
//            "width": 850,
//            "height": 1008,
//            "url": "https://cdn2.thecatapi.com/images/EPF2ejNS0.jpg"
//        }
//    }
