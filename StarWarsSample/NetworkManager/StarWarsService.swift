//
//  StarWarsService.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation


class StarWarsService {
    static let sharedInstance = StarWarsService()
    
    private init() {}
}

extension StarWarsService {
    
    func getAllPlanets(page: String, completion: @escaping (String?, String?, Int?) -> ()) {
        let urlRequest = StarWarsRouter.getPlanets(page).asurlRequest()
        StarWarsHTTPClient.sharedInstance.requestData(urlrequest: urlRequest) { (response) in
            switch response {
            case .Success(let response, let  statusCode):
                completion(response, nil, statusCode)
            case .Invalid(let message, let statusCode):
                completion(message, nil, statusCode)
            case .Failure(let error, let statusCode):
                completion(nil, error, statusCode)
            }
        }
    }
}
