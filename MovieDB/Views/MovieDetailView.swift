//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by rifqi triginandri on 27/01/25.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    let movieId: String

    var body: some View {
        ScrollView {
            if let movie = viewModel.movieDetail {
                VStack(alignment: .leading, spacing: 16) {
                    if let backdropPath = movie.backdropPath, let url = URL(string: APIConfig.imageBaseURL + backdropPath) {
                        AsyncImage(url: URL(string: APIConfig.imageBaseURL + backdropPath)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                        } placeholder: {
                            ProgressView()
                        }

                    }

                    Text(movie.title)
                        .font(.largeTitle)
                        .bold()

                    Text(movie.tagline ?? "")
                        .italic()
                        .foregroundColor(.gray)

                    Text("Overview")
                        .font(.headline)

                    Text(movie.overview ?? "")

                    Text("Genres: \(movie.genres.map { $0.name }.joined(separator: ", "))")
                        .font(.subheadline)

                    Text("Runtime: \(movie.runtime ?? 0) minutes")

                    Text("Release Date: \(movie.releaseDate)")

                    if let homepage = movie.homepage, let homepageURL = URL(string: homepage) {
                        Button(action: {
                            UIApplication.shared.open(homepageURL)
                        }) {
                            HStack {
                                Image(systemName: "link")
                                Text("Visit Homepage")
                                    .underline()
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    
                    if let trailerKey = viewModel.trailerKey {
                        Text("Watch Trailer")
                            .font(.headline)
                        WebView(url: URL(string: "\(APIConfig.trailerBaseURL)\(trailerKey)")!)
                            .frame(height: 200)
                            .cornerRadius(20)
                    }

                    Text("User Reviews")
                        .font(.headline)

                    ForEach(viewModel.reviews, id: \.id) { review in
                        VStack(alignment: .leading) {
                            Text("Author: \(review.author)")
                                .font(.subheadline)
                                .bold()
                            Text(review.content)
                                .font(.body)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .accessibilityIdentifier("movieList")
        .onAppear {
            viewModel.fetchMovieDetail(movieId: movieId)
            viewModel.fetchMovieReviews(movieId: movieId)
            viewModel.fetchTrailer(movieId: movieId)
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

