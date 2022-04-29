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
    var storedAds: Bindable<[Ad]> { get }
    var error: Bindable<Error> { get }
    var reloadDataWithIndex: Bindable<Int> { get }
    var isFavourites: Bool { get set }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let api: API
    private let storage: Storable
    var ads = Bindable<[Ad]>()
    var storedAds = Bindable<[Ad]>()
    var error = Bindable<Error>()
    var reloadDataWithIndex = Bindable<Int>()
    var isFavourites: Bool = false

    init(with api: API, storage: Storable) {
        self.api = api
        self.storage = storage
    }
    
    func fetchAds() {
        getStoredAds()
        let request = AdsRequest()
        api.send(request) {[weak self] result in
            switch result {
            case .success(let response):
                self?.ads.value = response.items
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
    func toggleFavourite(for selectedAd: Ad?) {
        guard var selectedAd = selectedAd, let ads = ads.value else { return }
        
        selectedAd.isFavourite.toggle()
        
        if selectedAd.isFavourite {
            storeAd(selectedAd)
        } else {
            removeFromStored(selectedAd)
        }
        
        getStoredAds()

        ads.enumerated().forEach { index, ad in
            if ad == selectedAd {
                reloadDataWithIndex.value = index
            }
        }
    }
        
    private func getStoredAds() {
        let items: [Ad] = storage.getItems()
        storedAds.value = items
    }
    
    private func storeAd(_ ad: Ad) {
        storage.store(ad)
    }
    
    private func removeFromStored(_ ad: Ad) {
        storage.remove(ad)
    }
}


