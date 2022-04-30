//
//  DetailsViewModel.swift
//  AdsApp
//
//  Created by Andrii Momot on 30.04.2022.
//

import Foundation

protocol DetailsViewModelProtocol {
    var ad: Ad { get }
    var adStored: (() -> Void)? { get set }
    
    func toggleFavourite()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    private let storage: Storable
    var ad: Ad
    var adStored: (() -> Void)?

    init(with storage: Storable, ad: Ad) {
        self.storage = storage
        self.ad = ad
    }
    
    func toggleFavourite() {
        ad.isFavourite.toggle()
        
        if ad.isFavourite {
            storeAd(ad)
        } else {
            removeFromStored(ad)
        }
        adStored?()
    }
    
    private func storeAd(_ ad: Ad) {
        storage.store(ad)
    }
    
    private func removeFromStored(_ ad: Ad) {
        storage.remove(ad)
    }
}
