//
//  Planet.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 30/07/2020.
//

import Foundation

struct Vehicle: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let crew: String
    let passengers: String
    let films: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case homeworld
        case films
        case starships
    }
}
extension Character: Displayable {
    var title: String {
        name
    }

    var text1Left: (label: String, value: String) {
        ("Birth:", birthYear)
    }

    var text2Left: (label: String, value: String) {
        ("Gender:", gender)
    }

    var text1Right: (label: String, value: String) {
        ("Height:", height)
    }

    var text2Right: (label: String, value: String) {
        ("Eye:", eyeColor)
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

