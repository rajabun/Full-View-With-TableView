//
//  TabBarViewController.swift
//  Full-View-With-TableView
//
//  Created by Muhammad Rajab on 11-07-2024.
//

import UIKit

public class TabBarViewController: UITabBarController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()

        //for change tab bar color and font/tint color
//        self.tabBar.tintColor = .white
//        self.tabBar.backgroundColor = .gray
    }
    
    func setupViewControllers() {
        let firstVC = ViewController()
        firstVC.tabBarItem.image = UIImage(systemName: "house")
        firstVC.tabBarItem.title = "Home"

        let secondVC = ConferenceVideoSessionsViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        secondVC.tabBarItem.title = "Search"
        
        let thirdVC = InsetItemsGridViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "qrcode")
        thirdVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        thirdVC.tabBarItem.title = "QR Code"
        
        let fourthVC = ViewController()
        fourthVC.tabBarItem.image = UIImage(systemName: "filemenu.and.selection")
        fourthVC.tabBarItem.title = "Accordion"
        
        let fifthVC = ViewController()
        fifthVC.tabBarItem.image = UIImage(systemName: "gear")
        fifthVC.tabBarItem.title = "Settings"

        viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Handle the user selecting a different tab
    }
}

extension TabBarViewController {
    //optional settings
    func tabBarSettings() {
        if #available(iOS 13.0, *) {
            let tabAppearance = UITabBarAppearance()

            tabAppearance.configureWithOpaqueBackground()
            tabAppearance.backgroundImage = UIImage()
            tabAppearance.backgroundColor = .blue

            tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.white

            tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
            tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

            UITabBar.appearance().standardAppearance = tabAppearance

            if #available(iOS 15, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabAppearance
            }

            setNeedsStatusBarAppearanceUpdate()

            tabBarController?.tabBar.tintColor = .white
            tabBarController?.tabBar.barTintColor = UIColor.yellow
            tabBarController?.tabBar.isTranslucent = false
        } else {
            // Handle older versions prior to iOS 13.0
            tabBarController?.tabBar.tintColor = .white
            tabBarController?.tabBar.barTintColor = UIColor.blue
            tabBarController?.tabBar.isTranslucent = false
        }
    }
}
