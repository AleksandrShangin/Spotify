//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Alex on 4/30/21.
//

import UIKit

class PlayerViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
        controlsView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlsView.frame = CGRect(x: 10, y: imageView.bottom+10, width: view.width-20, height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }
    
    
    private func configureBarButtons() {
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.leftBarButtonItem = leftBarButton
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
        
    }

}


extension PlayerViewController: PlayerControlsViewDelegate {
    
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapBackward(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapForward(_ playerControlsView: PlayerControlsView) {
        
    }
    
}
