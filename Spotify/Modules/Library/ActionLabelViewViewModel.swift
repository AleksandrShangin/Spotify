//
//  ActionLabelViewViewModel.swift
//  Spotify
//
//  Created by Alex on 10/29/21.
//

import Foundation

struct ActionLabelViewViewModel {
    let text: String
    let actionTitle: String
}

enum ActionLabelType {
    case playlist
    case album
}
