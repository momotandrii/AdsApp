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
    private let numberOfColunmns: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureCollectionView()
        binding()
        fetchAds()
    }
    
    func configureNavigation() {
        let customSwitch = UISwitch()
        customSwitch.isOn = false
        customSwitch.setOn(false, animated: true)

        customSwitch.addTarget(self, action: #selector(switchTarget(sender:)), for: .valueChanged)
        let label = UILabel()
        label.text = "Favourites"
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: customSwitch),
                                                   UIBarButtonItem(customView: label)]
    }


    @objc func switchTarget(sender: UISwitch) {
        viewModel?.isFavourites = sender.isOn
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        let reuseId = String(describing: AdCell.self)
        let cellNib = UINib(nibName: reuseId, bundle: Bundle(for: AdCell.self))
        collectionView.register(cellNib, forCellWithReuseIdentifier: reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchAds() {
        viewModel?.fetchAds()
    }
    
    private func binding() {
        viewModel?.ads.bind {[weak self] ads in
            DispatchQueue.main.async {
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
        
        viewModel?.reloadDataWithIndex.bind {[weak self] index in
            guard let index = index else { return }
                DispatchQueue.main.async {
                let indexPath = IndexPath(row: index, section: 0)
                self?.collectionView.reloadItems(at: [indexPath])
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let count = viewModel?.ads.value?.count, count > indexPath.row else { return }
        
//        viewModel?.getAlbumInfo(for: albumID)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = viewModel?.ads.value?.count ?? 0
        let numberOfFilteredItems = viewModel?.storedAds.value?.count ?? 0
        return viewModel?.isFavourites == true ? numberOfFilteredItems : numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = String(describing: AdCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? AdCell else { return UICollectionViewCell() }
        
        if viewModel?.isFavourites == true {
            guard var ad = viewModel?.storedAds.value?[indexPath.row] else { return cell }
            ad.isFavourite = true
            cell.configure(with: ad)
        } else {
            guard var ad = viewModel?.ads.value?[indexPath.row] else { return cell }
            if let stored = viewModel?.storedAds.value, stored.contains(ad) {
                ad.isFavourite = true
            }
            cell.configure(with: ad)
        }
        
        cell.favouriteAction = {[weak self] ad in
            self?.viewModel?.toggleFavourite(for: ad)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout to render desired numberOfColunmns
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
           return CGSize()
       }

       // subtract section left/ right insets mentioned in xib view
       let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)

       // Calculating widthForOneItem for desired numberOfColunmns by sunbtracting item spacing if any
       let widthForOneItem = widthAvailbleForAllItems / numberOfColunmns - flowLayout.minimumInteritemSpacing

       return CGSize(width: CGFloat(widthForOneItem), height: (flowLayout.itemSize.height))
    }
}
