//
//  FeaturedPlaylistCellViewModel.swift
//  Spotify
//
//  Created by Alex on 5/14/21.
//

import Foundation

struct FeaturedPlaylistCellViewModel {
    
    let name: String
    let artworkURL: URL?
    let creatorName: String
    
    init(playlist: Playlist) {
        self.name = playlist.name
        self.artworkURL = URL(string: playlist.images.first?.url ?? "")
        self.creatorName = playlist.owner.display_name
    }
    
}
