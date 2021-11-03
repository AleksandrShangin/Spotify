//
//  NewReleasesCellViewModel.swift
//  Spotify
//
//  Created by Alex on 5/13/21.
//

import Foundation

struct AlbumViewModel {
    
    let name: String
    let artistName: String
    
    let artworkURL: URL?
    let numberOfTracks: Int?
    let releaseDate: String?
    
    var tracksLabel: String? {
        return "Tracks: \(numberOfTracks ?? 0)"
    }
    
    var description: String {
        return "Release Date: \(String.formattedDate(string: releaseDate ?? ""))"
    }
    
    init(album: Album) {
        self.name = album.name
        self.artworkURL = URL(string: album.images.first?.url ?? "")
        self.numberOfTracks = album.total_tracks
        self.artistName = album.artists.first?.name ?? "-"
        self.releaseDate = album.release_date
    }
    
}
