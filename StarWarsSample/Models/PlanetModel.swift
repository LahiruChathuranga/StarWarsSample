//
//  PlanetModel.swift
//  StarWarsSample
//
//  Created by Lahiru Chathuranga on 2021-11-14.
//

import Foundation

struct PlanetModel : Codable {
    let name : String?
    let rotation_period : String?
    let orbital_period : String?
    let diameter : String?
    let climate : String?
    let gravity : String?
    let terrain : String?
    let surface_water : String?
    let population : String?
    let residents : [String]?
    let films : [String]?
    let created : String?
    let edited : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case rotation_period = "rotation_period"
        case orbital_period = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surface_water = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        rotation_period = try values.decodeIfPresent(String.self, forKey: .rotation_period)
        orbital_period = try values.decodeIfPresent(String.self, forKey: .orbital_period)
        diameter = try values.decodeIfPresent(String.self, forKey: .diameter)
        climate = try values.decodeIfPresent(String.self, forKey: .climate)
        gravity = try values.decodeIfPresent(String.self, forKey: .gravity)
        terrain = try values.decodeIfPresent(String.self, forKey: .terrain)
        surface_water = try values.decodeIfPresent(String.self, forKey: .surface_water)
        population = try values.decodeIfPresent(String.self, forKey: .population)
        residents = try values.decodeIfPresent([String].self, forKey: .residents)
        films = try values.decodeIfPresent([String].self, forKey: .films)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        edited = try values.decodeIfPresent(String.self, forKey: .edited)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
