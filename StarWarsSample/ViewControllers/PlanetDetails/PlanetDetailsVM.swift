//
//  PlanetDetailsVM.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class PlanetDetailsVM {
    var planetImage = BehaviorRelay<UIImage?>(value: nil)
    var name = BehaviorRelay<String>(value: "")
    var gravity = BehaviorRelay<String>(value: "")
    var orbitalPeriod = BehaviorRelay<String>(value: "")
    
    func bindData(with model: PlanetModel, imageInfo: UIImage?) {
        planetImage.accept(imageInfo)
        name.accept(model.name ?? "-")
        gravity.accept(model.gravity ?? "-")
        orbitalPeriod.accept(model.orbital_period ?? "-")
    }
}
