//
//  HomeCoordinator.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let api: API
    private let storage: Storable
    private var homeViewController: HomeViewController?
    
    init(presenter: UINavigationController, api: API, storage: Storable) {
        self.presenter = presenter
        self.api = api
        self.storage = storage
    }
    
    override func start() {
        let viewModel = HomeViewModel(with: api, storage: storage)
        let homeViewController = instantiate(HomeViewController.self)
        homeViewController.viewModel = viewModel
        homeViewController.title = "Ads"
        
        presenter.pushViewController(homeViewController, animated: true)
        
        self.homeViewController = homeViewController
    }
}
