//
//  MovieListView.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel: MovieViewModel
    let title: String
    let type: MovieType
    let initialPage: Int

    init(title: String, type: MovieType, initialPage: Int) {
        self.title = title
        self.type = type
        self.initialPage = initialPage
        _viewModel = StateObject(wrappedValue: MovieViewModel())
    }

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.movies(for: type), id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: String(movie.id))) {
                        MovieRow(movie: movie)
                            .onAppear {
                                Task {
                                    if viewModel.hasMorePages && !viewModel.isLoading {
                                        await viewModel.loadMoreMovies(for: type)
                                    }
                                }
                            }
                    }.buttonStyle(PlainButtonStyle())
                }

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding(.horizontal)
        }
        .accessibilityIdentifier("movieList")
        .navigationTitle(title)
        .onAppear {
            Task {
                if viewModel.movies(for: type).isEmpty {
                    if type == .nowPlaying {
                        await viewModel.fetchMovies(for: .nowPlaying, type: type, page: initialPage)
                    } else if type == .topRated {
                        await viewModel.fetchMovies(for: .topRated, type: type, page: initialPage)
                    } else if type == .upcoming {
                        await viewModel.fetchMovies(for: .upcoming, type: type, page: initialPage)
                    }
                }
            }
        }
    }
}

