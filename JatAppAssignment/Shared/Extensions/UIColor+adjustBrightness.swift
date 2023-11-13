//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

extension UIColor {
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return adjustBrightness(by: -1 * abs(percentage))
    }
    
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        return if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            UIColor(
                red: min(red + percentage / 100, 1.0),
                green: min(green + percentage / 100, 1.0),
                blue: min(blue + percentage / 100, 1.0),
                alpha: alpha
            )
        } else {
            .black
        }
    }
}
