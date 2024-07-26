//
//  ScrollingListView.swift
//  WhopSwiftUI
//
//  Created by Sam Bridge on 7/26/24.
//

import SwiftUI

struct ScrollingListView<VM: Scrollable>: View {
    @StateObject var viewModel: VM
    let linkPreviewing: Bool = true
    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            case .error(let errorMessage):
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            case .loaded:
                Text("Welcome to WHOP")
            }
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.content) { listCellModel in
                        ListCellView(listCellModel: listCellModel, previewing: linkPreviewing)
                            .padding()
                            .onAppear {
                                if listCellModel == viewModel.content.last {
                                    viewModel.fetchNextContent()
                                }
                            }
                    }
                }
            }.refreshable {
                viewModel.refresh()
            }
        }
    }
}


#Preview {
    ScrollingListView(viewModel: ScrollingListViewModel(content: .init()))
}
