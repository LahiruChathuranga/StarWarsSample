//
//  AppSettings.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation

enum Environment {
    case development
}

struct AppConstant {
    
    // change the environment when needed.
    static var environment: Environment = .development
    
    // Base URL
    static var BASE_URL: String = {
        switch environment {
        case .development:
            return "https://swapi.dev/api"
        }
    }()
}
