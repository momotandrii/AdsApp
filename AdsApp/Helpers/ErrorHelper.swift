//
//  ErrorHelper.swift
//  AdsApp
//
//  Created by Andrii Momot on 27.04.2022.
//

import Foundation

enum AppError: String, Error {
    case defaultError = "Oooops. Something went wrong! Please try again later."
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        return rawValue
    }
}
