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
        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if viewController is UINavigationController {
            ((viewController as! UINavigationController).viewControllers[0] as! FavouritesViewController).populateData()
        }
    }
}
