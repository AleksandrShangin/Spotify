//
//  UserProfile.swift
//  Spotify
//
//  Created by Alex on 4/30/21.
//

import Foundation



struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
//    let followers: [String: Codable?]
    let id: String
    let images: [APIImage]
    let product: String
}

