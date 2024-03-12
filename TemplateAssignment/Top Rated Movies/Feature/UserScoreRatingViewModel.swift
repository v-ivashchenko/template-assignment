//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

struct UserScoreRatingViewModel {
    
    // MARK: - Public properties
    let value: Double
    
    var circlularValue: CGFloat {
        CGFloat(percentageValue) / 100
    }
    
    var ratingString: String {
        return String(percentageValue) + "%"
    }
    
    var backgroundColor: CGColor {
        color.darker().cgColor
    }
    
    var foregroundColor: CGColor {
        color.cgColor
    }
    
    // MARK: - Private properties
    private var percentageValue: Int {
        Int((value * 10).rounded())
    }
    
    private var color: UIColor {
        if percentageValue >= 70 {
            UIColor.positiveUserScore
        } else if percentageValue >= 40 && percentageValue < 75 {
            UIColor.neutralUserScore
        } else {
            UIColor.negativeUserScore
        }
    }
}
