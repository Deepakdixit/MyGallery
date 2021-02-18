//
//  Constants.swift
//  MyGallery
//
//  Created by Deepak Dixit on 1/12/19.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit
import Reachability

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/**
 Its a singleton class, That contains reachability and Useful constant which i can access from anywhere in application and its instance will be created only once.
 
 This class contains some global functionality like Reachability which we are using throughout the applicaiton.
 */

class Constants: NSObject {
    public static let shared = Constants()
    let reachability = Reachability()!
    
    private override init() {
        super.init()
    }
    
    public func configure() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
    }
    
    /**
     Here I am checking reachability once network status change it fires notification that is handled here.
     - Parameter note: Its contains all the information about notification.
 */
    
    @objc func reachabilityChanged(note: Notification)  {
        if reachability.connection == .none{
            UIApplication.shared.showAlert("No network")
        }
    }
}

extension UIApplication {
    /**
     This function returns the top most presented view controller of application.
     */
    func topViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
    
    /**
     A global method to present the alert on the top most view controller.
     - Parameter message: An string that will be a message of alert controller.
     */
    func showAlert(_ message:String) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.topViewController()?.present(controller, animated: true, completion: nil)
    }
}

extension UIViewController {
    /**
     The function "topMostViewController" returns a top most view controller of the application which is presented on the screen.
     */
    func topMostViewController() -> UIViewController? {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController?.topMostViewController()
    }
}
