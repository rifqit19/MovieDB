//
//  MovieReview.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//


struct MovieReviewsResponse: Decodable {
    let results: [MovieReview]
}

struct MovieReview: Decodable {
    let id: String
    let author: String
    let content: String
}
