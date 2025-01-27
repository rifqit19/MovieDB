//
//  MovieCard.swift
//  MovieDB
//
//  Created by rifqi triginandri on 26/01/25.
//


import SwiftUI

struct NowPlayingMovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterPath = movie.posterPath, let url = URL(string: APIConfig.imageBaseURL + posterPath) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                    
                } placeholder: {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 150, height: 200)
                            .cornerRadius(15)

                        ProgressView()
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 200)
                    .cornerRadius(15)
            }
            Text(movie.title)
                .font(.caption)
                .bold()
                .lineLimit(1)
        }
        .frame(width: 150)
    }
}
