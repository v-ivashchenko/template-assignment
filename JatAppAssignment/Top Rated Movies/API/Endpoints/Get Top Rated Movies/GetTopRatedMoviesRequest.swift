//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class GetTopRatedMoviesRequest {
    
    static func request() -> URLRequest {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")!
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGYwMmQwMWQ4Y2FhNDhkY2Y0NTU4NmNjOWJhOTIwMSIsInN1YiI6IjY1NGZkNDRkNjdiNjEzMDBjODRiNzg0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yyZIdrsV1NDZPL9lHdQdQenL007bfe4IOCeZQR4AMLw"
        ]
        
        return request
    }
}
