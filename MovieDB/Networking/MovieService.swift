//
//  MovieService.swift
//  MovieDB
//
//  Created by rifqi triginandri on 26/01/25.
//


import Foundation
import Alamofire

class MovieService {
    func fetchMovies(endpoint: APIEndpoints, page: Int = 1) async throws -> MovieResponse {
        let url = endpoint.url
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(APIConfig.apiKey)",
            "Content-Type": "application/json"
        ]

        let parameters: [String: Any] = ["page": page]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, parameters: parameters, headers: headers)
                .validate()
                .responseDecodable(of: MovieResponse.self) { response in
                    switch response.result {
                    case .success(let movieResponse):
                        continuation.resume(returning: movieResponse)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
