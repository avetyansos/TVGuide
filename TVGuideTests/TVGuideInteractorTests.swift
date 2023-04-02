//
//  TVGuideInteractorTests.swift
//  TVGuideTests
//
//  Created by Sos Avetyan on 4/2/23.
//

import XCTest
@testable import TVGuide

final class TVGuideInteractorTests: XCTestCase {

    var interactor: TVGuideInteractor!
    var output: TVGuideInteractorOutputMock!
    var apiClient: MockTVGuideAPIClient!

    override func setUpWithError() throws {
        super.setUp()
        output = TVGuideInteractorOutputMock()
        apiClient = MockTVGuideAPIClient()
        interactor = TVGuideInteractor()
        interactor.apiClient = apiClient
        interactor.output = output
    }

    func testFetchTVGuideDataSuccess()  throws {
        let channel = Channel(orderNum: 1, accessNum: 2, callSign: "Test", id: 3)
        apiClient.channelsResult = .success([channel])

        let programItem = ProgramItem(startTime: Date(), recentAirTime: ProgramItemRecentAirTime(id: 4, channelID: 5), length: 60, shortName: "Short", name: "Name")
        apiClient.programItemsResult = .success([programItem])

        let expectation = self.expectation(description: "fetchTVGuideData")
        output.completion = {
            expectation.fulfill()
        }
        interactor.fetchTVGuideData()

        waitForExpectations(timeout: 7, handler: nil)

        XCTAssertEqual(output.channels?.count, 1)
        XCTAssertEqual(output.programs?.count, 1)
    }

    func testFetchTVGuideDataFailure() throws {
        apiClient.channelsResult = .failure(TVGuideError.generalError(message:"Channels error"))
        apiClient.programItemsResult = .failure(TVGuideError.generalError(message: "ProgramItems error"))
        let expectation = self.expectation(description: "fetchTVGuideData")
        output.completion = {
            expectation.fulfill()
        }

        interactor.fetchTVGuideData()
        waitForExpectations(timeout: 7, handler: nil)

        XCTAssertNotNil(output.error)
    }

}
