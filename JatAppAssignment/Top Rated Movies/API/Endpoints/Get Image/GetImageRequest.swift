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
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
}
