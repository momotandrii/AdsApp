//
//  HomeViewController.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        fetchAds()
    }
    
    private func fetchAds() {
        viewModel?.fetchAds()
    }
    
    private func binding() {
        viewModel?.ads.bind {[weak self] ads in
            DispatchQueue.main.async {
//                if let count = artists?.count {
//                    self?.searchFooter.setFooter(with: count)
//                }
                self?.activity.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
        
        viewModel?.error.bind {[weak self] error in
            DispatchQueue.main.async {
                self?.activity.stopAnimating()
                self?.showAlert(withTitle: "Error", message: error?.localizedDescription)
            }
        }
    }
}
