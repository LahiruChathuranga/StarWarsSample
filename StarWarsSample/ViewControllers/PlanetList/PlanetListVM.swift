//
//  PlanetListVM.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation
import RxSwift
import RxCocoa

class PlanetListVM {
    var planetList = BehaviorRelay<[PlanetModel]>(value: [])
    var metaData: MetaObject?
    
    
    func fetchPlanets(isLoadMore: Bool, page: String, completion: @escaping (_ staus: Bool) -> ()) {
        StarWarsService.sharedInstance.getAllPlanets(page: page) { response, error, statusCode in
            if error != nil {
                print(error ?? "")
                completion(false)
            } else {
                let planetsMeta = response?.parse(to: MetaObject.self)
                self.metaData = planetsMeta
                if isLoadMore {
                    var prevValues = self.planetList.value
                    prevValues.append(contentsOf: planetsMeta?.results ?? [])
                    self.planetList.accept(prevValues)
                } else {
                    self.planetList.accept(planetsMeta?.results ?? [])
                }
                completion(true)
            }
        }
    }
}
