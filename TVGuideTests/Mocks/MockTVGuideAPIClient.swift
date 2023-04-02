//
//  MockTVGuideAPIClient.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import Foundation
@testable import TVGuide

class MockTVGuideAPIClient: TVGuideAPIClientProtocol {
    var channelsResult: Result<[Channel], Error>?
    var programItemsResult: Result<[ProgramItem], Error>?

    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        if let result = channelsResult {
            completion(result)
        }
    }

    func fetchProgramItems(completion: @escaping (Result<[ProgramItem], Error>) -> Void) {
        if let result = programItemsResult {
            completion(result)
        }
    }
}
