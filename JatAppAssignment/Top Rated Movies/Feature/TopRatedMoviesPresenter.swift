//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class TopRatedMoviesPresenter {
    
    // MARK: - Private properties
    private let client: HTTPClient
    private let imageCache: ImageCache
    
    private var movies = [TopRatedMoviesCellViewModel]()
    private let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "")
    
    // MARK: - Public properties
    private(set) var filteredMovies = [TopRatedMoviesCellViewModel]()
    
    weak var view: TopRatedMoviesViewProtocol?
    
    // MARK: - Initialization
    init(client: HTTPClient, imageCache: ImageCache) {
        self.client = client
        self.imageCache = imageCache
    }
    
    // MARK: - Public methods
    func numberOfRowsInSection(_ section: Int) -> Int {
        filteredMovies.count
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
        
        return filteredMovies[indexPath.row]
    }
    
    func loadMovies() {
        Task {
            await MainActor.run {
                view?.startLoading()
            }
            
            let (data, response) = try await client.data(for: GetTopRatedMoviesRequest.request())
            let movies = try GetTopRatedMoviesMapper.map(data: data, from: response)
            
            queue.sync {
                self.movies = movies.results.map {
                    .init(title: $0.title, imagePath: $0.posterPath, rating: $0.voteAverage)
                }
                filteredMovies = self.movies
            }
            
            await MainActor.run {
                view?.reloadData()
                view?.stopLoading()
            }
        }
    }
    
    func filter(by searchText: String) {
        DispatchQueue.global().async {
            self.queue.sync {
                if searchText.isEmpty {
                    self.filteredMovies = self.movies
                } else {
                    self.filteredMovies = self.movies
                        .filter { $0.title.lowercased().contains(searchText.lowercased()) }
                }
            }
            
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
    func resetSearch() {
        queue.sync {
            filteredMovies = movies
        }
        
        view?.reloadData()
    }
    
    // MARK: - Private methods
    private func loadImage(at indexPath: IndexPath) async throws -> UIImage {
        let movie = queue.sync {
            filteredMovies[indexPath.row]
        }
        
        if let image = try await imageCache.image(by: movie.imagePath) {
            assignImage(image, at: indexPath, for: movie)
            
            return image
        } else {
            let (data, response) = try await client.data(for: GetImageRequest.request(size: .small, filePath: movie.imagePath))
            let imageData = try GetImageMapper.map(data: data, from: response)
            let image = UIImage(data: imageData) ?? UIImage()
            
            try await imageCache.setImage(image, by: movie.imagePath)
            assignImage(image, at: indexPath, for: movie)
            
            return image
        }
    }
    
    private func assignImage(_ image: UIImage, at indexPath: IndexPath, for movie: TopRatedMoviesCellViewModel) {
        queue.sync {
            var viewModel = movie
            viewModel.image = image
            
            if let index = movies.firstIndex(where: { $0.imagePath == movie.imagePath }) {
                movies[index] = viewModel
            }
            
            if let index = self.filteredMovies.firstIndex(where: { $0.imagePath == movie.imagePath }) {
                self.filteredMovies[index] = viewModel
            }
        }
    }
}
