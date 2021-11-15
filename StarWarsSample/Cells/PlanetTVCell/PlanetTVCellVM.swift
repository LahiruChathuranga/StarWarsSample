//
//  PlanetTVCellVM.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation
import RxSwift
import RxCocoa

class PlanetTVCellVM {
    var name = BehaviorRelay<String>(value: "")
    var planetClimate = BehaviorRelay<String>(value: "")
    
    func configureCell(with model: PlanetModel) {
        name.accept(model.name ?? "-")
        planetClimate.accept("Climate : \(model.climate ?? "-")")
    }
}

