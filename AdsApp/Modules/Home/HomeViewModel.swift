//
//  HomeViewModel.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchAds()
    func toggleFavourite(for selectedAd: Ad?)
    
    var ads: Bindable<[Ad]> { get }
    var error: Bindable<Error> { get }
    var reloadDataWithIndex: Bindable<Int> { get }
    var isFavourites: Bool { get set }
    var adsToShow: [Ad]? { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let api: API
    private let storage: Storable
    var ads = Bindable<[Ad]>()
    private var storedAds = Bindable<[Ad]>()
    var error = Bindable<Error>()
    var reloadDataWithIndex = Bindable<Int>()
    var isFavourites: Bool = false {
        didSet {
            updateAds(ads.value)
        }
    }

    init(with api: API, storage: Storable) {
        self.api = api
        self.storage = storage
    }
    
    // Array to show depends on Favourite switch value
    var adsToShow: [Ad]? {
        return isFavourites == true ? storedAds.value : ads.value
    }

    func fetchAds() {
        getStoredAds()
        let request = AdsRequest()
        api.send(request) {[weak self] result in
            switch result {
            case .success(let response):
                self?.updateAds(response.items)
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
    // Makes Ads up to date with local stored Ads changes
    private func updateAds(_ ads: [Ad]?){
        guard let stored = storedAds.value else {
            self.ads.value = ads
            return
        }
        self.ads.value = ads?.map { ad in
            if stored.contains(ad) {
                ad.isFavourite = true
            } else {
                ad.isFavourite = false
            }
            return ad
        }
    }
    
    func toggleFavourite(for selectedAd: Ad?) {
        guard let selectedAd = selectedAd else { return }
                
        if !selectedAd.isFavourite {
            storeAd(selectedAd)
        } else {
            removeFromStored(selectedAd)
        }
        
        adsToShow?.enumerated().forEach { index, ad in
            if ad == selectedAd {
                ad.isFavourite.toggle()
                reloadDataWithIndex.value = index
            }
        }
        
        getStoredAds()
    }
        
    private func getStoredAds() {
        let items: [Ad] = storage.getItems()
        storedAds.value = items.map { ad in
            ad.isFavourite = true
            return ad
        }
    }
    
    private func storeAd(_ ad: Ad) {
        storage.store(ad)
    }
    
    private func removeFromStored(_ ad: Ad) {
        storage.remove(ad)
    }
}


