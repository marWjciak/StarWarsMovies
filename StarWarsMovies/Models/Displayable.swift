//
//  Displayable.swift
//  StarWarsMovies
//
//  Created by Marcin Wójciak on 30/07/2020.
//

import Foundation

protocol Displayable {
    var title: String { get }
    var text1Left: (label: String, value: String) { get }
    var text2Left: (label: String, value: String) { get }
    var text1Right: (label: String, value: String) { get }
    var text2Right: (label: String, value: String) { get }
    var itemListTitle: String { get }
    var itemListTitleKeyword: String { get }
    var itemList: [String] { get }
        }
