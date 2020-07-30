//
//  CHaracter.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 28/07/2020.
//

import Foundation

struct Character: Decodable {
    let name: String
    let height: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let films: [String]
    let starships: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case height
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case films
        case starships
    }
}
extension Character: Displayable {
    var headTitle: String {
        "Characters"
    }
    
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
