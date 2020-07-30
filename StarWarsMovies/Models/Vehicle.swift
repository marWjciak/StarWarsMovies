//
//  Vehicle.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 30/07/2020.
//

import Foundation

struct Vehicle: Decodable {
    let name: String
    let length: String
    let maxSpeed: String
    let crew: String
    let passengers: String
    let films: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case length
        case maxSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case films
    }
}

extension Vehicle: Displayable {
    var title: String {
        name
    }

    var text1Left: (label: String, value: String) {
        ("Lenght:", length)
    }

    var text2Left: (label: String, value: String) {
        ("Max speed:", maxSpeed)
    }

    var text1Right: (label: String, value: String) {
        ("Crew:", crew)
    }

    var text2Right: (label: String, value: String) {
        ("Passengers:", passengers)
    }

    var itemListTitle: String {
        "--- Films ---"
    }

    var itemListTitleKeyword: String {
        "title"
    }

    var itemList: [String] {
        films
    }
}
