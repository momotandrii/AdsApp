//
//  AppCoordinator.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import UIKit

final class AppCoordinator: Coordinator {
    let api: API
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let homeCoordinator: HomeCoordinator
    
    // MARK: - Place to declare initial viewCOntroller
    init(window: UIWindow) {
        self.window = window
        api = AppAPI()
        rootViewController = UINavigationController()
        
        homeCoordinator = HomeCoordinator(presenter: rootViewController, api: api)
    }
    
    func start() {
        window.rootViewController = rootViewController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
