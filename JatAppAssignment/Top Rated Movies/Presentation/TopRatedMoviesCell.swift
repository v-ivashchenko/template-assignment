//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class TopRatedMoviesCell: UITableViewCell {
    
    // MARK: - Private properties
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let userScoreView: UserScoreRatingView = {
        let view = UserScoreRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let characterOccurrencesLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Public properties
    static let reuseIdentifier = String(describing: TopRatedMoviesCell.self)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        userScoreView.value = 0
        titleLabel.text = nil
        characterOccurrencesLabel.text = nil
    }
    
    // MARK: - Public methods
    func configure(with viewModel: TopRatedMoviesCellViewModel) {
        posterImageView.image = viewModel.image
        userScoreView.value = viewModel.rating
        titleLabel.text = viewModel.title
        characterOccurrencesLabel.text = viewModel.characterOccurrences
    }
    
    func updateImage(_ image: UIImage) {
        posterImageView.image = image
    }
    
    // MARK: - Private methods
    private func configureView() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(userScoreView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(characterOccurrencesLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Design.defaultPadding),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.defaultPadding),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Design.defaultPadding),
            posterImageView.heightAnchor.constraint(equalToConstant: 450),
            
            userScoreView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            userScoreView.centerYAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            userScoreView.widthAnchor.constraint(equalToConstant: 48),
            userScoreView.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: userScoreView.bottomAnchor, constant: Design.defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Design.defaultPadding),
            
            characterOccurrencesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            characterOccurrencesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Design.defaultPadding),
            characterOccurrencesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Design.defaultPadding),
            characterOccurrencesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Design.defaultPadding)
        ])
    }
}
