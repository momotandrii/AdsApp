//
//  DetailsCoordinator.swift
//  AdsApp
//
//  Created by Andrii Momot on 30.04.2022.
//

import UIKit

final class DetailsCoordinator: BaseCoordinator {
    private let presenter: UINavigationController
    private let storage: Storable
    private let ad: Ad
    private var detailsViewController: DetailsViewController?

    init(presenter: UINavigationController, storage: Storable, ad: Ad) {
        self.presenter = presenter
        self.storage = storage
        self.ad = ad
    }
    
    override func start() {
        let viewModel = DetailsViewModel(with: storage, ad: ad)
        let detailsViewController = instantiate(DetailsViewController.self)
        detailsViewController.viewModel = viewModel
        detailsViewController.title = "Details"
        
        presenter.pushViewController(detailsViewController, animated: true)
        
        self.detailsViewController = detailsViewController
    }
}
