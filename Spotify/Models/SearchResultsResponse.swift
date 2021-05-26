//
//  SearchResultsResponse.swift
//  Spotify
//
//  Created by Alex on 5/26/21.
//

import Foundation


struct SearchResultsResponse: Codable {
    let albums: SearchAlbumsResponse
    let artists: SearchArtistsResponse
    let playlists: SearchPlaylistsResponse
    let tracks: SearchTracksResponse
}


struct SearchAlbumsResponse: Codable {
    let items: [Album]
}


struct SearchArtistsResponse: Codable {
    let items: [Artist]
}


struct SearchPlaylistsResponse: Codable {
    let items: [Playlist]
}


struct SearchTracksResponse: Codable {
    let items: [AudioTrack]
}
