//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Alex on 5/21/21.
//

import UIKit

final class AlbumTrackCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "AlbumTrackCollectionViewCell"
    
    // MARK: - UI
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
        
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.width-15,
                                      height: contentView.height/2)
        artistNameLabel.frame = CGRect(x: 10,
                                       y: contentView.height/2,
                                       width: contentView.width-15,
                                       height: contentView.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    // MARK: - Public Methods
    
    public func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
    
}
