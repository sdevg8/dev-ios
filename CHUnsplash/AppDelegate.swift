//
//  AppDelegate.swift
//  CHUnsplash
//
//  Created by user on 05/04/21.
//

import UIKit
import Toast_Swift
import ProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkNotification(notification:)), name: Notification.Name("reachabilityIdentifier"), object: nil)
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    @objc func networkNotification(notification: Notification) {
        if let rootViewController = UIApplication.getTopViewController() {
            rootViewController.view.makeToast("Please check your internet connection.")
            ProgressHUD.dismiss()
        }
    }
}

extension UIApplication {
    class func getTopViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(presented)
        }
        return base
    }
}

