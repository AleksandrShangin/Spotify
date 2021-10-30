//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Alex on 5/28/21.
//

import UIKit
import SDWebImage

class SearchResultDefaultTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "SearchResultDefaultTableViewCell"
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height-10
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        iconImageView.layer.cornerRadius = imageSize/2
        iconImageView.layer.masksToBounds = true
        titleLabel.frame = CGRect(x: iconImageView.right+10,
                                  y: 0,
                                  width: contentView.width-iconImageView.right-15,
                                  height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
    
}
