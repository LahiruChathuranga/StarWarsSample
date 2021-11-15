//
//  Localizator.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation

public class Localizator {
    class func NSLocalizedString(_ key: String) -> String {
        return Foundation.NSLocalizedString(key, comment: "")
    }
}

extension String {
    // View controllers
    static let PlanetListVC = Localizator.NSLocalizedString("PlanetListVC")
    static let PlanetDetailsVC = Localizator.NSLocalizedString("PlanetDetailsVC")
    
    // cells
    static let PlanetTVCell = Localizator.NSLocalizedString("PlanetTVCell")
}
