//
//  ListCellModel.swift
//  WhopSwiftUI
//
//  Created by Sam Bridge on 7/26/24.
//

import Foundation

public enum ListCellModelType: Hashable {
    case url(URL)
    case expandableFolder([ListCellModel])
}

public struct ListCellModelURL {
    let url: URL
}

public struct ListCellModel: Identifiable, Hashable {
    public let id: Int
    public let type: ListCellModelType
    
    public static func == (lhs: ListCellModel, rhs: ListCellModel) -> Bool {
        return lhs.id == rhs.id && lhs.type == rhs.type
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(type)
    }
}

extension ListCellModel {
    static var mockListCellURL: ListCellModel {
        return .init(id: UUID().hashValue, type: .url(URL(string: "https://www.apple.com")!))
    }
    
    static var expandableFolder: ListCellModel {
        return .init(id: UUID().hashValue, type: .expandableFolder([
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.apple.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.google.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.facebook.com")!)),
        ]))
    }
    
    static var mockData: [ListCellModel] {
        return [
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.apple.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.google.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.facebook.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.twitter.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.linkedin.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.instagram.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.reddit.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.youtube.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.wikipedia.org")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.amazon.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.ebay.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.netflix.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.spotify.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.github.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.stackoverflow.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.medium.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.tumblr.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.quora.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.dropbox.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.salesforce.com")!)),
            .init(id: UUID().hashValue, type: .expandableFolder([
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.apple.com")!)),
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.google.com")!)),
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.facebook.com")!)),
            ])),
            .init(id: UUID().hashValue, type: .expandableFolder([
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.twitter.com")!)),
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.linkedin.com")!)),
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.instagram.com")!)),
            ])),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.slack.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.microsoft.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.apple.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.airbnb.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.uber.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.adobe.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.shopify.com")!)),
            .init(id: UUID().hashValue, type: .url(URL(string: "https://www.paypal.com")!)),
            .init(id: UUID().hashValue, type: .expandableFolder([
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.tesla.com")!)),
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.spacex.com")!)),
                .init(id: UUID().hashValue, type: .url(URL(string: "https://www.nasa.gov")!)),
            ])),
        ]
    }
}
