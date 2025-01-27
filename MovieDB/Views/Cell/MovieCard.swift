//
//  MovieCard.swift
//  MovieDB
//
//  Created by rifqi triginandri on 26/01/25.
//


import SwiftUI

struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            if let posterPath = movie.posterPath, let url = URL(string: APIConfig.imageBaseURL + posterPath) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                    
                } placeholder: {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)

                        ProgressView()
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
            }
            Text(movie.title)
                .font(.caption)
                .lineLimit(1)
        }
        .frame(width: 100)
    }
}
