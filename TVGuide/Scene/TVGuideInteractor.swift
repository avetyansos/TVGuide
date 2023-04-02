//
//  TVGuideInteractor.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import Foundation

class TVGuideInteractor: TVGuideInteractorInput {
    weak var output: TVGuideInteractorOutput?
    var apiClient: TVGuideAPIClientProtocol?
    private var channels: [Channel]?
    private var programs: [ProgramItem]?
    
    func fetchTVGuideData() {
        let dispatchGroup = DispatchGroup()
        var fetchedChannels: [Channel]?
        var fetchedProgramItems: [ProgramItem]?
        // Fetch channels
        dispatchGroup.enter()
        apiClient?.fetchChannels { result in
            switch result {
            case .success(let channels):
                fetchedChannels = channels.map { Channel(orderNum: $0.orderNum, accessNum: $0.accessNum, callSign: $0.callSign, id: $0.id) }
            case .failure(let error):
                print("Error fetching channels: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        // Fetch program items
        dispatchGroup.enter()
        apiClient?.fetchProgramItems { result in
            switch result {
            case .success(let programs):
                fetchedProgramItems = programs.map { ProgramItem(startTime: $0.startTime, recentAirTime: ProgramItemRecentAirTime(id: $0.recentAirTime?.id, channelID: $0.recentAirTime?.channelID), length: $0.length, shortName: $0.shortName, name: $0.name) }
            case .failure(let error):
                print("Error fetching channels: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        // Wait for both requests to finish
        dispatchGroup.notify(queue: .main) {
            if let channels = fetchedChannels, let programItems = fetchedProgramItems {
                self.output?.tvGuideDataFetched(channels: channels, programs: programItems)
            } else {
                self.output?.tvGuideDataFetchFailed(error: "Something went wrong")
            }
        }
    }
}

