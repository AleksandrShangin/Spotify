//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Alex on 5/13/21.
//

import UIKit

final class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    // MARK: - UI
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        return label
    }()
        
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = CGRect(x: 3,
                                        y: contentView.height-30,
                                        width: contentView.width-6,
                                        height: 30)
        playlistNameLabel.frame = CGRect(x: 3,
                                         y: contentView.height-60,
                                         width: contentView.width-6,
                                         height: 30)
        let imageSize: CGFloat = contentView.height-70
        playlistCoverImageView.frame = CGRect(x: (contentView.width-imageSize)/2, y: 3, width: imageSize, height: imageSize)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
}
