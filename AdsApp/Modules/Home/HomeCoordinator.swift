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
    private var homeViewController: HomeViewController?
    
    init(presenter: UINavigationController, api: API) {
      self.presenter = presenter
      self.api = api
    }
    
    override func start() {
        let viewModel = HomeViewModel(with: api)
        let homeViewController = instantiate(HomeViewController.self)
        homeViewController.viewModel = viewModel

        presenter.pushViewController(homeViewController, animated: true)
        
        self.homeViewController = homeViewController
    }
}
