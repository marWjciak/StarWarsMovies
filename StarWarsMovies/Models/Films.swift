//
//  Films.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 25/07/2020.
//

import Foundation

struct Films: Decodable {
    let count: Int
    let all: [Film]

    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
