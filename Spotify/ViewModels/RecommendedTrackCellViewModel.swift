//
//  RecommendedTrackCellViewModel.swift
//  Spotify
//
//  Created by Alex on 5/14/21.
//

import Foundation

struct RecommendedTrackCellViewModel {
    
    let name: String
    let artistName: String
    let artworkURL: URL?
    
    init(track: AudioTrack) {
        self.name = track.name
        self.artistName = track.artists.first?.name ?? "-"
        self.artworkURL = URL(string: track.album?.images.first?.url ?? "")
    }
    
}
