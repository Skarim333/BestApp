//
//  PostSortable.swift
//  BestAppTest
//
//  Created by Карим Садыков on 30.11.2022.
//

import Foundation

// MARK: - PostSortable Protocol

protocol PostSortable {
    
}

extension PostSortable {
    /// Sorts given Flickr posts by a specified sort order.
    /// - Returns: a sorted array of Flickr posts.
    static func sort(_ posts: [Item], by order: SortOrder) -> [Item] {
        switch order {
        case .publishingDate:
            return posts.sorted(by: { $0.published < $1.published })
        case .creationData:
            return posts.sorted(by: { $0.date_taken < $1.date_taken })
        }
    }
}


// MARK: Sort Order

enum SortOrder: Int, CaseIterable {
    case publishingDate
    case creationData
}

extension SortOrder {
    var localizedTitle: String {
        switch self {
        case .publishingDate:
            return NSLocalizedString("Publication Date", comment: "")
        case .creationData:
            return NSLocalizedString("Creation Date", comment: "")
        }
    }
}
