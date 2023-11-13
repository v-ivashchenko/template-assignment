//
//  Copyright © 2023 Vitalii Ivashchenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let presenter = TopRatedMoviesPresenter()
        let rootViewController = TopRatedMoviesViewController(presenter: presenter)
        presenter.view = rootViewController
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
