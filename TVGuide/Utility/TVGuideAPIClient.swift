//
//  TVGuideAPIClient.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

class TVGuideAPIClient: TVGuideAPIClientProtocol {

    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void) {
        DefaultAPI.channelsGet  { channelItems, error in
            guard let channelItems = channelItems else {
                completion(.failure(error!))
                return
            }
            completion(.success(channelItems))
        }
    }

    func fetchProgramItems(completion: @escaping (Result<[ProgramItem], Error>) -> Void) {
        DefaultAPI.programItemsGet { programItems, error in
            guard let programItems = programItems else {
                completion(.failure(error!))
                return
            }
            completion(.success(programItems))
        }
    }
}

