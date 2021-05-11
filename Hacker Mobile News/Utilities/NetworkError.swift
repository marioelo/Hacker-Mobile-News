//
//  NetworkError.swift
//  Hacker Mobile News
//
//  Created by Mario Elorza on 07-05-21.
//

import Foundation

enum NetworkError: String, Error {
    case invalidUrl = "There was an error constructing the url"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
