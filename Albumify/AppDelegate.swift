//
//  AppDelegate.swift
//  Albumify
//
//  Created by Mert Gürcan on 12.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .green
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]

        window = UIWindow()
        let nav = UINavigationController(rootViewController: AlbumsBuilder.create())
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        

        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

