//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import XCTest
@testable import JatAppAssignment

final class UserScoreRatingViewModelTests: XCTestCase {

    func test_positiveRating() {
        let sut = UserScoreRatingViewModel(value: 7.012)
        
        XCTAssertEqual(sut.circlularValue, 0.70)
        XCTAssertEqual(sut.ratingString, "70%")
        XCTAssertEqual(sut.backgroundColor, UIColor.positiveUserScore.darker().cgColor)
        XCTAssertEqual(sut.foregroundColor, UIColor.positiveUserScore.cgColor)
    }
    
    func test_neutralRating() {
        let sut = UserScoreRatingViewModel(value: 4.012)
        
        XCTAssertEqual(sut.circlularValue, 0.40)
        XCTAssertEqual(sut.ratingString, "40%")
        XCTAssertEqual(sut.backgroundColor, UIColor.neutralUserScore.darker().cgColor)
        XCTAssertEqual(sut.foregroundColor, UIColor.neutralUserScore.cgColor)
    }
    
    func test_negativeRating() {
        let sut = UserScoreRatingViewModel(value: 0.012)
        
        XCTAssertEqual(sut.circlularValue, 0.0)
        XCTAssertEqual(sut.ratingString, "0%")
        XCTAssertEqual(sut.backgroundColor, UIColor.negativeUserScore.darker().cgColor)
        XCTAssertEqual(sut.foregroundColor, UIColor.negativeUserScore.cgColor)
    }
}
