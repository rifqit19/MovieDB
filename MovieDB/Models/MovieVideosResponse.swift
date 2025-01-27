//
//  MovieVideosResponse.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//


struct MovieVideosResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable {
    let name: String
    let key: String
    let site: String
    let type: String
}