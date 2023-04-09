//
//  TVGuidePresenter.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

class TVGuidePresenter: TVGuideViewOutput, TVGuideInteractorOutput {
    weak var view: TVGuideViewInput?
    var interactor: TVGuideInteractorInput?
    var router: TVGuideRouterInput?

    private(set) var channels: [Channel] = []
    private(set) var programs: [ProgramItem] = []

    func viewDidLoad() {
        interactor?.fetchTVGuideData()
    }

    func tvGuideDataFetched(channels: [Channel], programs: [ProgramItem]) {
        self.channels = channels
        self.programs = programs
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }

    func tvGuideDataFetchFailed(error: Error) {
        print("Error fetching TV guide data: \(error.localizedDescription)")

        // Handle the error, such as displaying an alert to the user
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertController = UIAlertController(title: "Error",
                                                    message: "Failed to fetch TV guide data. Please try again.",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            guard let view = self.view as? TVGuideView else { return }
            view.present(alertController, animated: true)
        }
    }
}

