//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let client = URLSessionHTTPClient()
        let imageCache = InMemoryImageCache()
        let presenter = TopRatedMoviesPresenter(client: client, imageCache: imageCache)
        let viewController = TopRatedMoviesViewController(presenter: presenter)
        viewController.onSelectMovie = { movie in
            let viewModel = TopRatedMoviesDetailViewModel(title: movie.title, image: movie.image, rating: movie.rating)
            let rootView = TopRatedMoviesDetailView(viewModel: viewModel)
            
            return UIHostingController(rootView: rootView)
        }
        presenter.view = viewController
        
        let rootViewController = UINavigationController(rootViewController: viewController)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
