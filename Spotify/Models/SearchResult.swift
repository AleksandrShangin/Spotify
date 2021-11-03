//
//  SearchResult.swift
//  Spotify
//
//  Created by Alex on 5/26/21.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
