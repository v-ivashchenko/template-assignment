//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class TopRatedMoviesPresenter {
    
    // MARK: - Private properties
    private let client: HTTPClient
    
    private var movies = [TopRatedMoviesCellViewModel]()
    
    // MARK: - Public properties
    weak var view: TopRatedMoviesViewProtocol?
    
    // MARK: - Initialization
    init(client: HTTPClient) {
        self.client = client
    }
    
    // MARK: - Public methods
    func numberOfRowsInSection(_ section: Int) -> Int {
        movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TopRatedMoviesCellViewModel {
        movies[indexPath.row]
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
}
