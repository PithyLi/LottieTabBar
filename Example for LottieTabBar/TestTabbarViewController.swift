//
//  TestTabbarViewController.swift
//  Test
//
//  Created by Jayz Zz on 2018/11/16.
//  Copyright © 2018 Jayz Zz. All rights reserved.
//

import UIKit

class TestTabbarViewController: LottieTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = UIViewController()
        firstVC.view.backgroundColor = UIColor.orange

        let secondVC = UIViewController()
        secondVC.view.backgroundColor = UIColor.yellow

        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = UIColor.blue

        self.tabbars = [firstVC, secondVC, thirdVC]
//        self.addTabLottieView(jsons: ["tab_message_animate", "tab_me_animate", "tab_search_animate"])
        self.addTabLottieView(jsons: ["tab_message_animate", "tab_me_animate", "tab_search_animate"], titles: ["new", "mine", "search"])
        self.selectedIndex = 0

        self.tabBar.setBadgeStatus(index: 1, isHidden: false)
        self.tabBar.setBadgeStatus(index: 0, isHidden: false, count: 100)
        self.tabBar.setBadgeStatus(index: 2, isHidden: false, count: 9)

        // Do any additional setup after loading the view.
    }

}
