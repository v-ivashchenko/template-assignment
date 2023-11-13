//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let presenter = TopRatedMoviesPresenter()
        let rootViewController = TopRatedMoviesViewController(presenter: presenter)
        rootViewController.onSelectMovie = { movie in
            let viewModel = TopRatedMoviesDetailViewModel(title: movie.title, image: movie.image, rating: movie.rating)
            let rootView = TopRatedMoviesDetailView(viewModel: viewModel)
            
            return UIHostingController(rootView: rootView)
        }
        presenter.view = rootViewController
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
