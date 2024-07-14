//
//  NCError+Utils.swift
//  Netflix Clone
//
//  Created by Noah Pope on 7/14/24.
//

import Foundation

enum NCDatabaseError: String, Error {
    case failedToSaveData   = "Failed to save the data."
    case failedToFetchData  = "Failed to fetch the data."
    case failedToDeleteData = "Failed to delete the data."
}

enum NCAPIError: String, Error {
    case failedToGetData    = "Failed to get the data."
}
