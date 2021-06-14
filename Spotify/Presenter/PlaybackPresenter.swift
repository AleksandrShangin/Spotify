//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Alex on 5/30/21.
//

import UIKit
import AVFoundation



protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}


final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.queuePlayer, !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
    
    var playerVC: PlayerViewController?

    private var player: AVPlayer?
    private var queuePlayer: AVQueuePlayer?
    
    private init() {}
    
    public func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        guard let url = URL(string: track.preview_url ?? "") else {
            print("No preview url for this song..")
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    public func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else { return nil }
            return AVPlayerItem(url: url)
        })
        self.queuePlayer = AVQueuePlayer(items: items)
        self.queuePlayer?.volume = 0.1
        self.queuePlayer?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        self.playerVC = vc
    }
    
    
}


extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
}


extension PlaybackPresenter: PlayerViewControllerDelegate {
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = queuePlayer {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
        }
        else if let player = queuePlayer {
            player.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
            
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        } else if let firstItem = queuePlayer?.items().first {
            queuePlayer?.pause()
            queuePlayer?.removeAllItems()
            queuePlayer = AVQueuePlayer(items: [firstItem])
            queuePlayer?.play()
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
    
}
