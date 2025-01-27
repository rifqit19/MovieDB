//
//  NowPlayingSectionView.swift
//  MovieDB
//
//  Created by rifqi triginandri on 26/01/25.
//

import SwiftUI

struct NowPlayingSectionView<Destination: View>: View {
    let title: String
    let movies: [Movie]
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                NavigationLink(destination: destination) {
                    Text("See More")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: String(movie.id))) {
                            NowPlayingMovieCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
