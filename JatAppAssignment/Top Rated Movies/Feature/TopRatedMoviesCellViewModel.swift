//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

struct TopRatedMoviesCellViewModel {
    
    let title: String
    let imagePath: String
    let rating: Double
    
    var image: UIImage = UIImage(systemName: "photo")!
    
    var characterOccurrences: String {
        var dictionary = [String: Int]()
        
        title.forEach { character in
            guard character.isLetter else { return }
            
            let character = character.lowercased()
            dictionary[character] = (dictionary[character] ?? 0) + 1
        }
        
        return dictionary
            .sorted(by: <)
            .map { $0.key + " - " + String($0.value) }
            .joined(separator: ", ")
    }
}
