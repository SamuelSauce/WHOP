//
//  ContentView.swift
//  WhopSwiftUI
//
//  Created by Sam Bridge on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollingListView(viewModel: ScrollingListViewModel(content: .init()))
    }
}

#Preview {
    ContentView()
}
