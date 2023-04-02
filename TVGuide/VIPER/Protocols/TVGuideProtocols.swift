//
//  TVGuideProtocols.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//
import UIKit

protocol TVGuideViewInput: AnyObject {
    func reloadData()
}

protocol TVGuideViewOutput {
    func viewDidLoad()
    var channels: [Channel] { get }
    var programs: [ProgramItem] { get }
}

protocol TVGuideInteractorInput {
    func fetchTVGuideData()
}

protocol TVGuideInteractorOutput: AnyObject {
    func tvGuideDataFetched(channels: [Channel], programs: [ProgramItem])
    func tvGuideDataFetchFailed(error: Error)
}

protocol TVGuideRouterInput {
    // Add navigation methods if necessary
}

protocol TVGuideModuleInput {
    func configure(view: TVGuideViewInput)
}

