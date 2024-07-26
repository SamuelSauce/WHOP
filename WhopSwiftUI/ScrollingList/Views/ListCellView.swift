//
//  ListCellView.swift
//  WhopSwiftUI
//
//  Created by Sam Bridge on 7/26/24.
//

import SwiftUI
import LinkPresentation

//TODO: Take styling elements and stardize them in some design systems part of the project for re-use and consistency.
struct ListCellView: View {
    let listCellModel: ListCellModel
    let previewing: Bool

    @State private var isExpanded: Bool = false
    @State private var isWebViewPresented: Bool = false
    @State private var metaData: LPLinkMetadata?
    @State private var isLoading: Bool = false

    //TODO: Overall clean up this view, perhaps two different types of cell views to remove all of the clutter from this bloated view.
    var body: some View {
        switch listCellModel.type {
        case .url(let url):
            if let metaData = self.metaData {
                Button(action: {
                    isWebViewPresented = true
                }) {
                    LinkPreview(metaData: metaData)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                .sheet(isPresented: $isWebViewPresented) {
                    WebView(url: url)
                }
            } else {
                HStack {
                    Image(systemName: "link.circle.fill")
                        .foregroundColor(.blue)
                    Text(url.absoluteString)
                        .foregroundColor(.blue)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    if isLoading {
                        ProgressView()
                    }
                    Button(action: {
                        isWebViewPresented = true
                    }) {
                        Image(systemName: "arrow.up.right.square")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .sheet(isPresented: $isWebViewPresented) {
                    WebView(url: url)
                }.onAppear {
                    if !previewing { return }
                    let provider = LPMetadataProvider()
                    Task {
                        self.isLoading = true
                        do {
                            self.metaData = try await provider.startFetchingMetadata(for: url)
                        } catch {
                            self.isLoading = false
                        }
                    }
                }
            }
            
        case .expandableFolder(let contents):
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "folder.fill")
                        .foregroundColor(.yellow)
                    Text("Folder")
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
                if isExpanded {
                    ForEach(contents) { item in
                        ListCellView(listCellModel: item, previewing: previewing)
                            .padding(.leading, 20)
                    }
                }
            }
        }
    }
}

import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct LinkPreview: UIViewRepresentable {
  var metaData: LPLinkMetadata
  func makeUIView(context: Context) -> LPLinkView {
    let preview = LPLinkView(metadata: metaData)

    return preview
  }

  func updateUIView(_ uiView: LPLinkView, context: Context) {
    uiView.metadata = metaData
  }
}



#Preview {
    VStack {
        ListCellView(listCellModel: .mockListCellURL, previewing: true)
        ListCellView(listCellModel: .expandableFolder, previewing: false)
    }
    .padding()
}
