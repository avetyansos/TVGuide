//
//  TVGuideRouter.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

class TVGuideRouter: TVGuideRouterInput {
    weak var viewController: UIViewController?

    // Implement navigation methods if necessary
}

class TVGuideConfigurator: TVGuideModuleInput {

    func configure(view: TVGuideViewInput) {
        let presenter = TVGuidePresenter()
        let interactor = TVGuideInteractor()
        let router = TVGuideRouter()

        // Configure the API client
        let apiClient = TVGuideAPIClient()
        interactor.apiClient = apiClient

        if let view = view as? TVGuideView {
            view.configure(presenter: presenter)
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router

            interactor.output = presenter

            router.viewController = view
        }

    }
}

