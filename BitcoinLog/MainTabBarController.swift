//
//  MainTabBarController.swift
//  BitcoinLog
//
//  Created by Viktor Rutberg on 09/11/15.
//  Copyright © 2015 Viktor Rutberg. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        print("setting self as delegate...")
        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("stuff was tapped: \(viewController)")
        if viewController is UINavigationController {
            print("populating data...")
            ((viewController as! UINavigationController).viewControllers[0] as! FavouritesViewController).populateData()
        }
    }
}
