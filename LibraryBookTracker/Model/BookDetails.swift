//
//  BookDetails.swift
//  LibraryBookTracker
//
//  Created by Brian Surgenor on 02/02/2020.
//  Copyright © 2020 Brian Surgenor. All rights reserved.
//

import Foundation

struct BookDetails: Decodable {
    let items: [BookVolume]
}

struct BookVolume: Decodable {
    let volumeInfo: Volume
}

struct Volume: Decodable {
    let title: String
    let subtitle: String
    let authors: [String]
}
