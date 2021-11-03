//
//  BrowseSectionType.swift
//  Spotify
//
//  Created by Alex on 10/30/21.
//

import Foundation

enum BrowseSectionType {
    case newReleases(viewModels: [AlbumViewModel]) // 1
    case featuredPlaylists(viewModels: [FeaturedPlaylistCellViewModel]) // 2
    case recommendedTracks(viewModels: [RecommendedTrackCellViewModel]) // 3
    
    var title: String {
        switch self {
        case .newReleases:
            return "New Released Albums"
        case .featuredPlaylists:
            return "Featured Playlists"
        case .recommendedTracks:
            return "Recommended"
        }
    }
}
