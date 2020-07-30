//
//  Film.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 25/07/2020.
//

import Foundation

struct Film: Decodable {
    let id: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let planets: [String]
    let starships: [String]

    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case planets
        case starships
    }
}

extension Film: Comparable {
    static func < (lhs: Film, rhs: Film) -> Bool {
        return lhs.id < rhs.id
    }
}