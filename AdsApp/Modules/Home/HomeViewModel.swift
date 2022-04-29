//
//  HomeViewModel.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchAds()

    var ads: Bindable<[Ad]> { get }
    var error: Bindable<Error> { get }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let api: API
    var ads = Bindable<[Ad]>()
    var error = Bindable<Error>()

    init(with api: API) {
        self.api = api
    }
    
    func fetchAds() {
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
}
