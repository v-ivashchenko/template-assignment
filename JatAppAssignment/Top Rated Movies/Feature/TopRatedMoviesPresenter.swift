//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class TopRatedMoviesPresenter {
    
    // MARK: - Private properties
    private let client: HTTPClient
    private let imageCache: ImageCache
    
    // MARK: - Public properties
    private(set) var movies = [TopRatedMoviesCellViewModel]()
    
    weak var view: TopRatedMoviesViewProtocol?
    
    // MARK: - Initialization
    init(client: HTTPClient, imageCache: ImageCache) {
        self.client = client
        self.imageCache = imageCache
    }
    
    // MARK: - Public methods
    func numberOfRowsInSection(_ section: Int) -> Int {
        movies.count
    }
    
    func cellForRowAt(
        indexPath: IndexPath,
        imageLoadingCompletion: @escaping (UIImage) -> Void
    ) -> TopRatedMoviesCellViewModel {
        Task {
            let image = try await loadImage(at: indexPath)
            
            await MainActor.run {
                imageLoadingCompletion(image)
            }
        }
        
        return movies[indexPath.row]
    }
    
    func loadMovies() {
        Task {
            await MainActor.run {
                view?.startLoading()
            }
            
            let (data, response) = try await client.data(for: GetTopRatedMoviesRequest.request())
            let movies = try GetTopRatedMoviesMapper.map(data: data, from: response)
            
            self.movies = movies.results.map {
                .init(title: $0.title, imagePath: $0.posterPath, rating: $0.voteAverage)
            }
            
            await MainActor.run {
                view?.reloadData()
                view?.stopLoading()
            }
        }
    }
    
    func filter(by searchText: String) {
        
    }
    
    // MARK: - Private methods
    private func loadImage(at indexPath: IndexPath) async throws -> UIImage {
        let movie = movies[indexPath.row]
        
        if let image = try await imageCache.image(by: movie.imagePath) {
            var viewModel = movie
            viewModel.image = image
            movies[indexPath.row] = viewModel
            
            return image
        } else {
            let (data, response) = try await client.data(for: GetImageRequest.request(size: .small, filePath: movie.imagePath))
            let imageData = try GetImageMapper.map(data: data, from: response)
            let image = UIImage(data: imageData)!
            
            try await imageCache.setImage(image, by: movie.imagePath)
            
            var viewModel = movie
            viewModel.image = image
            movies[indexPath.row] = viewModel
            
            return image
        }
    }
}
