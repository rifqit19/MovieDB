//
//  APIEndpoints.swift
//  FoodFinder
//
//  Created by rifqi triginandri on 25/01/25.
//


import Foundation

enum APIEndpoints {
    case popular
    case nowPlaying
    case topRated
    case upcoming
    case detail(String)
    case reviews(String)
    case videos(String)

    
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .nowPlaying:
            return "/movie/now_playing"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        case .detail(let movieId):
            return "/movie/\(movieId)"
        case .reviews(let movieId):
            return "/movie/\(movieId)/reviews"
        case .videos(let movieId):
            return "/movie/\(movieId)/videos"


        }
    }
    
    var url: String {
        return APIConfig.baseURL + path
    }
}
