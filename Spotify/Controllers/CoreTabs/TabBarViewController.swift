//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Alex on 4/30/21.
//

import UIKit
import ColorCompatibility


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)

        nav1.navigationBar.tintColor = ColorCompatibility.label
        nav2.navigationBar.tintColor = ColorCompatibility.label
        nav3.navigationBar.tintColor = ColorCompatibility.label
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        if #available(iOS 13.0, *) {
            nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        } else {
            nav2.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        }
        if #available(iOS 13.0, *) {
            nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        } else {
            nav3.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        }
                
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}
