//
//  Movie.swift
//  iMovies
//
//  Created by Guilherme Muniz Viana on 18/08/25.
//

import Foundation

struct Movie: Codable {
    var title: String
    var categories: String
    var duration: String
    var rating: Float
    var summary: String
    var image: String
}
