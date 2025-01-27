//
//  MovieDetailService.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//


import Foundation
import Alamofire

class MovieDetailService {
    func fetchMovieDetail(movieId: String) async throws -> MovieDetail {
        let url = "\(APIConfig.baseURL)/movie/\(movieId)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConfig.apiKey)",
            "Content-Type": "application/json"
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, headers: headers)
                .validate()
                .responseDecodable(of: MovieDetail.self) { response in
                    switch response.result {
                    case .success(let movieDetail):
                        continuation.resume(returning: movieDetail)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func fetchMovieReviews(movieId: String) async throws -> [MovieReview] {
        let url = "\(APIConfig.baseURL)/movie/\(movieId)/reviews"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConfig.apiKey)",
            "Content-Type": "application/json"
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, headers: headers)
                .validate()
                .responseDecodable(of: MovieReviewsResponse.self) { response in
                    switch response.result {
                    case .success(let reviewResponse):
                        continuation.resume(returning: reviewResponse.results)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func fetchTrailer(movieId: String) async throws -> String? {
        let url = "\(APIConfig.baseURL)/movie/\(movieId)/videos"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConfig.apiKey)",
            "Content-Type": "application/json"
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, headers: headers)
                .validate()
                .responseDecodable(of: MovieVideosResponse.self) { response in
                    switch response.result {
                    case .success(let videoResponse):
                        let trailer = videoResponse.results.first { $0.type == "Trailer" && $0.site == "YouTube" }
                        continuation.resume(returning: trailer?.key)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
