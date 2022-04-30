//
//  AdCell.swift
//  AdsApp
//
//  Created by Andrii Momot on 28.04.2022.
//

import UIKit

final class AdCell: UICollectionViewCell {
    
    var favouriteAction: ((Ad?) -> Void)?
    var ad: Ad?
    
    @IBOutlet private weak var adImageView: LoadableImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adImageView.layer.cornerRadius = 8
        adImageView.clipsToBounds = true
        favouriteButton.setTitle("", for: .normal)
    }
    
    func configure(with ad: Ad?) {
        self.ad = ad
        
        titleLabel.text = ad?.title ?? ""
        locationLabel.text = ad?.location ?? ""
        
        let price = ad?.price?.formattedValue
        priceLabel.text = price ?? ""
        
        if let imageUrl = ad?.image?.fullParh {
            adImageView.loadImageWithUrl(urlString: imageUrl)
        }
        
        let image = ad?.isFavourite == true ? UIImage(named: "unlike") : UIImage(named: "like")
        favouriteButton.setImage(image, for: .normal)
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
        favouriteAction?(ad)
    }
}
