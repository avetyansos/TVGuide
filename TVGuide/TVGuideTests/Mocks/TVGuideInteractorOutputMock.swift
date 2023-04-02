//
//  TVGuideInteractorOutputMock.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import Foundation
@testable import TVGuide

class TVGuideInteractorOutputMock: TVGuideInteractorOutput {
    var channels: [Channel]?
    var programs: [ProgramItem]?
    var error: Error?
    var completion: (() -> Void)?

    func tvGuideDataFetched(channels: [Channel], programs: [ProgramItem]) {
        self.channels = channels
        self.programs = programs
        completion?()
    }

    func tvGuideDataFetchFailed(error: Error) {
        self.error = error
        completion?()
    }
}
