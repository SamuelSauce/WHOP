//
//  ScrollingListContentService.swift
//  WhopSwiftUI
//
//  Created by Sam Bridge on 7/26/24.
//

import Foundation

//TODO: Protocolize this as well so that the dependency can be injected for testing and whatnot.
public class ScrollingListContentService {
    
    public static func fetchNextContent(index: Int) async throws -> [ListCellModel] {
        //TODO: Make this fetch from somewhere legit
        
        // Simulate a half-second network delay
        try await Task.sleep(nanoseconds: 500_000_000)
        
        let allData = ListCellModel.mockData
        let startIndex = index
        let endIndex = min(index + 10, allData.count)
        
        guard startIndex < allData.count else {
            return []
        }
        
        return Array(allData[startIndex..<endIndex])
    }
}
