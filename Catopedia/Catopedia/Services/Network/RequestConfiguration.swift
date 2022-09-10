//
//  RequestConfiguration.swift
//  Catopedia
//
//  Created by Tania Jasam on 10/09/22.
//

import Foundation

enum HTTPRequestMethod: String {
    case GET, POST, PUT, DELETE
}

protocol RequestConfiguration {
    
    func getURL() -> URL?
    
    func getMethod() -> HTTPRequestMethod
    
    func getHeaders() -> [String: String]
    
    func getRequestBody() -> [String: Any]?
}

extension RequestConfiguration {
    
    func getMethod() -> HTTPRequestMethod {
         .GET
    }
    
    func getHeaders() -> [String: String] {
         ["x-api-key": "live_tNe64ApsR8LeX5QfAZnCre9PKY1npI2RL2W3sc0w4yklu1hMaFOu2iutOzhaUBiA"]
    }
    
    func getRequestBody() -> [String: Any]? {
         nil
    }
}
