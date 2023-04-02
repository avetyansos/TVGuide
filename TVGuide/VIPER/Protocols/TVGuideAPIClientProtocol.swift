//
//  TVGuideAPIClientProtocol.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import Foundation

protocol TVGuideAPIClientProtocol {
    func fetchChannels(completion: @escaping (Result<[Channel], Error>) -> Void)
    func fetchProgramItems(completion: @escaping (Result<[ProgramItem], Error>) -> Void)
}

