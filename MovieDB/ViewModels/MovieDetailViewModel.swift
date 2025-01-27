//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//


import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var reviews: [MovieReview] = []
    @Published var trailerKey: String?
    @Published var errorMessage: String?

    private let service = MovieDetailService()

    func fetchMovieDetail(movieId: String) {
        Task {
            do {
                let detail = try await service.fetchMovieDetail(movieId: movieId)
                movieDetail = detail
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func fetchMovieReviews(movieId: String) {
        Task {
            do {
                let reviewsList = try await service.fetchMovieReviews(movieId: movieId)
                reviews = reviewsList
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    func fetchTrailer(movieId: String) {
        Task {
            do {
                trailerKey = try await service.fetchTrailer(movieId: movieId)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
