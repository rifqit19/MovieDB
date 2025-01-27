//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by rifqi triginandri on 26/01/25.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    @Published var nowPlayingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []

    @Published var isLoading = false
    @Published var errorMessage: IdentifiableErrorMessage?
    @Published var hasMorePages = true
    private var currentPage: [MovieType: Int] = [
        .nowPlaying: 1,
        .topRated: 1,
        .upcoming: 1,
        .popular: 1
    ]

    private let movieService = MovieService()

    func fetchMovies(for endpoint: APIEndpoints, type: MovieType, page: Int = 1) async {
        isLoading = true
        do {
            let response = try await movieService.fetchMovies(endpoint: endpoint, page: page)
            handleResponse(response, for: type)
        } catch {
            errorMessage = IdentifiableErrorMessage(message: error.localizedDescription)
        }
        isLoading = false
    }
    private func handleResponse(_ response: MovieResponse, for type: MovieType) {
        let movies = response.results
        let currentPageNumber = response.page
        let totalPages = response.total_pages

        if !movies.isEmpty {
            switch type {
            case .nowPlaying:
                nowPlayingMovies = mergeUniqueMovies(currentMovies: nowPlayingMovies, newMovies: movies)
            case .topRated:
                topRatedMovies = mergeUniqueMovies(currentMovies: topRatedMovies, newMovies: movies)
            case .upcoming:
                upcomingMovies = mergeUniqueMovies(currentMovies: upcomingMovies, newMovies: movies)
            case .popular:
                popularMovies = mergeUniqueMovies(currentMovies: popularMovies, newMovies: movies)
            }
            hasMorePages = currentPageNumber < totalPages
            currentPage[type] = currentPageNumber + 1
        } else {
            hasMorePages = false
        }

    }
    private func mergeUniqueMovies(currentMovies: [Movie], newMovies: [Movie]) -> [Movie] {
        var movieSet = Set(currentMovies.map { $0.id })
        return currentMovies + newMovies.filter { movieSet.insert($0.id).inserted }
    }
    
    func loadMoreMovies(for type: MovieType) async {
        guard hasMorePages, let page = currentPage[type] else { return }
        let endpoint: APIEndpoints

        switch type {
        case .nowPlaying:
            endpoint = .nowPlaying
        case .topRated:
            endpoint = .topRated
        case .upcoming:
            endpoint = .upcoming
        case .popular:
            endpoint = .popular
        }

        await fetchMovies(for: endpoint, type: type, page: page)
    }

    func movies(for type: MovieType) -> [Movie] {
        switch type {
        case .nowPlaying:
            return nowPlayingMovies
        case .topRated:
            return topRatedMovies
        case .upcoming:
            return upcomingMovies
        case .popular:
            return popularMovies
        }
    }
}

enum MovieType {
    case nowPlaying
    case topRated
    case upcoming
    case popular
}
