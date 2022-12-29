//
//  ServiceError.swift
//  GHFollowers
//
//  Created by Samed Dağlı on 29.12.2022.
//

import Foundation

enum ServiceError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please check out typos and try again."
    case noUser             = "There is no user corresponding to this username"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
