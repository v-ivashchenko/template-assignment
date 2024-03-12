//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class GetTopRatedMoviesRequest {
    
    static func request() -> URLRequest {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")!
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
