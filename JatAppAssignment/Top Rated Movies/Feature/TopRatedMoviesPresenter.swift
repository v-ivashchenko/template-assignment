//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class TopRatedMoviesPresenter {
    
    // MARK: - Private properties
    private var movies = [TopRatedMoviesCellViewModel]()
    
    // MARK: - Public properties
    weak var view: TopRatedMoviesViewProtocol?
    
    // MARK: - Public methods
    func numberOfRowsInSection(_ section: Int) -> Int {
        movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TopRatedMoviesCellViewModel {
        movies[indexPath.row]
    }
    
    func loadMovies() {
        
    }
}
