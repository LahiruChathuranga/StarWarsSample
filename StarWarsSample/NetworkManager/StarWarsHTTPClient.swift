//
//  StarWarsHTTPClient.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Result<T> {
    case Success(String, Int)
    case Invalid(String, Int)
    case Failure(String, Int)
}

class StarWarsHTTPClient {
    
    static let sharedInstance = StarWarsHTTPClient()
    
    func requestData(urlrequest: URLRequest, completion: @escaping (Result<String>) -> Void) {
        // Continue with Alamofire request
        AF.request(urlrequest)
            .responseString { response in
                
                let statusCode = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        switch statusCode {
                        case 200...299:
                            completion(.Success(String(data: data, encoding: .utf8) ?? "", statusCode))
                        default:
                            let json = JSON(data)
                            let message = json["Error"].stringValue
                            completion(.Invalid(message, statusCode))
                        }
                    } else {
                        completion(.Success("", statusCode))
                    }
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        completion(.Failure("Request timeout", error._code))
                    } else {
                        completion(.Failure("Server connection failure", error._code))
                    }
                }
                
            }
    }
}
