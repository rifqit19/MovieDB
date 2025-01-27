//
//  MovieDetail.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//


struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let tagline: String?
    let overview: String?
    let genres: [Genre]
    let runtime: Int?
    let releaseDate: String
    let voteAverage: Double?
    let backdropPath: String?
    let posterPath: String?
    let homepage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, tagline, overview, genres, runtime, homepage
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}


