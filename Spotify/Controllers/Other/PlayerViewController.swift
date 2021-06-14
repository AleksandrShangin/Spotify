//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Alex on 4/30/21.
//

import UIKit
import SDWebImage
import ColorCompatibility



protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}



final class PlayerViewController: UIViewController {

    // MARK: - Propeties
    
    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    
    // MARK: - UI
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorCompatibility.systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
        controlsView.delegate = self
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlsView.frame = CGRect(x: 10, y: imageView.bottom+10, width: view.width-20, height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    
    @available(iOS 13.0, *)
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
    
    func refreshUI() {
        configure()
    }

}



// MARK: - Extension for PlayerControlsViewDelegate

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapBackward(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
    
    func playerControlsViewDidTapForward(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
}
