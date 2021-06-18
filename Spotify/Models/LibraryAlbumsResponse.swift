//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Alex on 6/18/21.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
    
}
