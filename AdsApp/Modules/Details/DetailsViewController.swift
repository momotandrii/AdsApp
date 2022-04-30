//
//  DetailsViewController.swift
//  AdsApp
//
//  Created by Andrii Momot on 30.04.2022.
//

import UIKit

final class DetailsViewController: BaseViewController {
    
    var viewModel: DetailsViewModelProtocol?

    @IBOutlet private weak var favouriteButton: UIButton!
    @IBOutlet private weak var imageView: LoadableImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        titleLabel.text = viewModel?.ad.title ?? ""
        locationLabel.text = viewModel?.ad.location ?? ""
        
        let price = viewModel?.ad.price?.formattedValue
        priceLabel.text = price ?? ""
        
        if let imageUrl = viewModel?.ad.image?.fullParh {
            imageView.loadImageWithUrl(urlString: imageUrl)
        }
        
        favouriteButton.setTitle("", for: .normal)
        configureFavouriteButton()
        
        viewModel?.adStored = {[weak self] in
            DispatchQueue.main.async {
                self?.configureFavouriteButton()
            }
        }
    }
    
    private func configureFavouriteButton() {
        let image = viewModel?.ad.isFavourite == true ? UIImage(named: "unlike") : UIImage(named: "like")
        favouriteButton.setImage(image, for: .normal)
    }
    
    @IBAction private func favouriteButtonAction(_ sender: Any) {
        viewModel?.toggleFavourite()
    }
}
