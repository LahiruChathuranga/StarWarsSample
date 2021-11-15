//
//  StarWarsNetworkManager.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//
import Foundation

enum StarWarsRouter {
    case getPlanets(String)
    
    var baseUrl: String {
        return AppConstant.BASE_URL
    }
    
    var path: String {
        switch self {
        case .getPlanets:
            return StarWarsEndPoints.getPlanets
        }
    }
    
    var httpMethod: String {
        return  StarWarsHttpMethodConstants.GET
    }
    
    var url: URL {
        switch self {
        case .getPlanets(let page):
            if page != "" {
                let urlString = baseUrl + path + "?page=\(page)"
                let encodedurlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                return URL(string: encodedurlString!)!
            } else {
                let urlString = baseUrl + path
                let encodedurlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                return URL(string: encodedurlString!)!
            }
        }
    }
   
    func sethttpBodyFromString(str: String) -> Data? {
        let data = str.data(using: .utf8)
        return data
    }
    
    //MARK: - url request
    func asurlRequest() -> URLRequest {
        var urlrequest = URLRequest(url: url)
        urlrequest.httpMethod = httpMethod
        urlrequest.addValue(StarWarsMediaType.CONTENT_TYPE_VALUE, forHTTPHeaderField: StarWarsMediaType.CONTENT_TYPE)
        
        switch self {
        case .getPlanets:
            return urlrequest
        }
    }
}
