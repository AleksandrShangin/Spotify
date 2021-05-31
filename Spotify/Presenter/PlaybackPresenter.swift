//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Alex on 5/30/21.
//

import UIKit


final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    private init() {}
    
    public func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    public func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    
}

