//
//  AppDelegate.swift
//  TVGuide
//
//  Created by Sos Avetyan on 4/2/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tvGuideView = TVGuideView.instantiateFromStoryboard()
        let configurator = TVGuideConfigurator()
        configurator.configure(view: tvGuideView)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: tvGuideView)
        window?.makeKeyAndVisible()
        return true
    }


}

