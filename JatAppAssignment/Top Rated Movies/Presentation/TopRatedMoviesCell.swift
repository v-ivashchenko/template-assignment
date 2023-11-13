//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class TopRatedMoviesCell: UITableViewCell {

    // MARK: - Private properties
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let userScoreView: UserScoreRatingView = {
        let view = UserScoreRatingView(frame: .init(x: 0, y: 0, width: 48, height: 48))
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
    
    // MARK: - Private methods
    private func configureView() {
        addSubview(posterImageView)
        addSubview(userScoreView)
        addSubview(titleLabel)
        addSubview(characterOccurrencesLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Design.defaultPadding),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Design.defaultPadding),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Design.defaultPadding),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            userScoreView.centerYAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            userScoreView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: Design.defaultPadding),
            userScoreView.widthAnchor.constraint(equalToConstant: 48),
            userScoreView.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: userScoreView.bottomAnchor, constant: Design.defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Design.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Design.defaultPadding),
            
            characterOccurrencesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            characterOccurrencesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Design.defaultPadding),
            characterOccurrencesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Design.defaultPadding),
            characterOccurrencesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Design.defaultPadding)
        ])
    }
}
