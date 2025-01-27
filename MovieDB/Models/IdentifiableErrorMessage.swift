//
//  IdentifiableErrorMessage.swift
//  MovieDB
//
//  Created by rifqi triginandri on 26/01/25.
//

import Foundation

struct IdentifiableErrorMessage: Identifiable {
    let id = UUID() // Memberikan ID unik
    let message: String
}
