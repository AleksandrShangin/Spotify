//
//  AuthResponse.swift
//  Spotify
//
//  Created by Alex on 5/2/21.
//

import Foundation


struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let token_type: String
}
