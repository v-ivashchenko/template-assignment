//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

class GetImageRequest {
    
    enum Size: String {
        case small = "w300", medium = "w780", large = "w1280", original
    }
    
    static func request(size: Size, filePath: String) -> URLRequest {
        let url = URL(string: "https://image.tmdb.org/t/p/\(size.rawValue)\(filePath)")!
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNGYwMmQwMWQ4Y2FhNDhkY2Y0NTU4NmNjOWJhOTIwMSIsInN1YiI6IjY1NGZkNDRkNjdiNjEzMDBjODRiNzg0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yyZIdrsV1NDZPL9lHdQdQenL007bfe4IOCeZQR4AMLw"
        ]
        
        return request
    }
}
