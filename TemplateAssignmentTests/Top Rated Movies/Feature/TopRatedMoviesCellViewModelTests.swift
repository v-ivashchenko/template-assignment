//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import TemplateAssignment

final class TopRatedMoviesCellViewModelTests: XCTestCase {

    func test_characterOccurrences_countsEveryLetter() {
        let sut = TopRatedMoviesCellViewModel(title: "any title", imagePath: "any", rating: 0)
        
        XCTAssertEqual(sut.characterOccurrences, "a - 1, e - 1, i - 1, l - 1, n - 1, t - 2, y - 1")
    }
}
