//
//  SettingsModel.swift
//  Spotify
//
//  Created by Alex on 5/10/21.
//

import Foundation



struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
