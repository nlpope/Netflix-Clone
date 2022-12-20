//
//  Movie.swift
//  Netflix Clone
//
//  Created by Noah Pope on 12/19/22.
//

import Foundation

//array
struct TrendingMoviesResponse: Codable {
    let results: [Movie]
}

//a single item in that array
struct Movie: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
