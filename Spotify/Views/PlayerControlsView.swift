//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Alex on 5/30/21.
//

import UIKit
import ColorCompatibility

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackward(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForward(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {
    
    // MARK: - Properties
    
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    // MARK: - UI
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "The Song Name"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = ColorCompatibility.secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorCompatibility.label
        let image = UIImage(systemName: "backward.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorCompatibility.label
        var image = UIImage()
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "forward.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))!
        } else {
            // Fallback on earlier versions
        }
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorCompatibility.label
        var image = UIImage()
        if #available(iOS 13.0, *) {
            image = UIImage(systemName: "pause.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))!
        } else {
            // Fallback on earlier versions
        }
        button.setImage(image, for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(volumeSlider)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(backButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        clipsToBounds = true
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44)
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: width/2-buttonSize/2,
                                       y: volumeSlider.bottom+30,
                                       width: buttonSize,
                                       height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left-80-buttonSize,
                                  y: volumeSlider.bottom+30,
                                  width: buttonSize,
                                  height: buttonSize)
        forwardButton.frame = CGRect(x: playPauseButton.right+80,
                                     y: volumeSlider.bottom+30,
                                     width: buttonSize,
                                     height: buttonSize)
    }
    
    // MARK: - Actions
    
    @objc private func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }
    
    @objc private func didTapBackButton() {
        delegate?.playerControlsViewDidTapBackward(self)
    }
    
    @objc private func didTapForwardButton() {
        delegate?.playerControlsViewDidTapForward(self)
    }
    
    @objc private func didTapPlayPauseButton() {
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPause(self)
        // Update icon
        let pause = UIImage(systemName: "pause.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill",
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
}
