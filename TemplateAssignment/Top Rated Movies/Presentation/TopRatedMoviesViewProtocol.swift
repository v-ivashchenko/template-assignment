//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import Foundation

protocol TopRatedMoviesViewProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func reloadData()
}
