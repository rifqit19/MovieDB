//
//  ContentView.swift
//  MovieDB
//
//  Created by rifqi triginandri on 25/01/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    NowPlayingSectionView(
                        title: "Now Playing",
                        movies: viewModel.nowPlayingMovies,
                        destination: MovieListView(
                            title: "Now Playing",
                            type: .nowPlaying,
                            initialPage: 1
                        )
                    )

                    RegularSectionView(
                        title: "Top Rated",
                        movies: viewModel.topRatedMovies,
                        destination: MovieListView(
                            title: "Top Rated",
                            type: .topRated,
                            initialPage: 1
                        )
                    )
                    
                    RegularSectionView(
                        title: "Upcoming",
                        movies: viewModel.upcomingMovies,
                        destination: MovieListView(
                            title: "Upcoming",
                            type: .upcoming,
                            initialPage: 1
                        )
                    )
                    
                    Text("Popular Movies")
                        .font(.headline)
                        .padding(.leading)

//                    LazyVStack {
//                        ForEach(viewModel.popularMovies, id: \.id) { movie in
//                            NavigationLink(destination: MovieDetailView(movieId: String(movie.id))) {
//                                MovieRow(movie: movie)
//                                    .onAppear {
//                                        Task {
//                                            if viewModel.hasMorePages && !viewModel.isLoading {
//                                                await viewModel.loadMoreMovies(for: .popular)
//                                            }
//                                        }
//                                    }
//                            }.buttonStyle(PlainButtonStyle())
//
//                        }
//                        if viewModel.isLoading {
//                            ProgressView()
//                                .padding()
//                        }
//                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(viewModel.popularMovies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailView(movieId: String(movie.id))) {
                                PopularMovieRow(movie: movie)
                                    .onAppear {
                                        Task {
                                            if viewModel.hasMorePages && !viewModel.isLoading {
                                                await viewModel.loadMoreMovies(for: .popular)
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
                .onAppear {
                    Task {
                        await viewModel.fetchMovies(for: .nowPlaying, type: .nowPlaying)
                        await viewModel.fetchMovies(for: .topRated, type: .topRated)
                        await viewModel.fetchMovies(for: .upcoming, type: .upcoming)
                        await viewModel.fetchMovies(for: .popular, type: .popular)
                    }
                }
                .navigationTitle("Movie List")
            }
            .accessibilityIdentifier("movieList")
        }
        .alert(item: $viewModel.errorMessage) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}


#Preview {
    MainView()
}
