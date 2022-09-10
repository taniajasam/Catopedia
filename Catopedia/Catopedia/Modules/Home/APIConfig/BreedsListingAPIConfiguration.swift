//
//  BreedsListingAPIConfiguration.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import Foundation

struct BreedsListAPIConfiguration: RequestConfiguration {
    var pageSize: Int
    var pageCount: Int
    
    init(pageSize: Int, pageCount: Int) {
        self.pageSize = pageSize
        self.pageCount = pageCount
    }
    
    func getURL() -> URL? {
        let url = URLList.baseURL.appending("breeds")
        return URL(string: url)
    }
    
    func getRequestBody() -> [String : Any]? {
        ["limit": pageSize,
         "page": pageCount]
    }
}
