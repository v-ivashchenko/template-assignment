//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI

struct UserScoreRatingViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = UserScoreRatingView
    
    @State var value: Double
    
    func makeUIView(context: Context) -> UIViewType {
        return UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.value = value
    }
}
