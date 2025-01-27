//
//  PopularMovieRow.swift
//  MovieDB
//
//  Created by rifqi triginandri on 28/01/25.
//


import SwiftUI

struct PopularMovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            if let posterPath = movie.posterPath, let url = URL(string: APIConfig.imageBaseURL + posterPath) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .frame(width: 70, height: 100)
                        .cornerRadius(10)
                } placeholder: {
                    ZStack{
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 70, height: 100)
                            .cornerRadius(10)
                        
                        ProgressView()
                    }
                    
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                .frame(width: 70, height: 100)
                .cornerRadius(10)
            }
            
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.body)
                    .lineLimit(2)
                                
                Text(movie.overview ?? "Unknown Date")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .lineLimit(3)

            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
