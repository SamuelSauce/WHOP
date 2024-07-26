//
//  ScrollingListViewModel.swift
//  WhopSwiftUI
//
//  Created by Sam Bridge on 7/26/24.
//

import Foundation

public enum ScrollableLoadingState {
    case loading
    case loaded
    case error(String)
}

@MainActor
class ScrollingListViewModel: Scrollable {
    @Published var loadingState: ScrollableLoadingState
    @Published var content: [ListCellModel]
    
    public init(content: [ListCellModel]) {
        self.content = content
        self.loadingState = .loaded
        fetchNextContent()
    }
    
    func fetchNextContent() {
        self.loadingState =  .loading
        Task {
            do {
                let newContent = try await ScrollingListContentService.fetchNextContent(index: self.content.count)
                self.content.append(contentsOf: newContent)
                self.loadingState = .loaded
            } catch {
                //TODO: Parse the error type perhaps and grab the message or something more dynamic than this static string
                self.loadingState = .error("Unable to fetch next line items")
            }
        }
    }
    
    func refresh() {
        self.content = []
        fetchNextContent()
    }
}

protocol Scrollable: ObservableObject {
    var loadingState: ScrollableLoadingState { get }
    var content: [ListCellModel] { get }
    func fetchNextContent()
    func refresh()
}
