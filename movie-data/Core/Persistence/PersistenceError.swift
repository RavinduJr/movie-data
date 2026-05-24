//
//  PersistenceError.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import Foundation

enum PersistenceError: Error, LocalizedError {
    case saveFailed
    case fetchFailed
    case deleteFailed
    case objectNotFound
    case invalidManagedObject
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Failed to save data"
        case .fetchFailed:
            return "Failed to fetch data"
        case .deleteFailed:
            return "Failed to delete data"
        case .objectNotFound:
            return "No data found"
        case .invalidManagedObject:
            return "Invalid managed object"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
