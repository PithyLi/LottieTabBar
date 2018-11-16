//
//  LottieTabBarViewController.swift
//  Test
//
//  Created by Jayz Zz on 2018/11/13.
//  Copyright © 2018 Jayz Zz. All rights reserved.
//

import UIKit

protocol LottieTabBarDelegate: class {

    func lottieTabBar(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController)

    func lottieTabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem, selectIndex: Int)
}

public class LottieTabBarViewController: UITabBarController {

    weak var lottieDelegate: LottieTabBarDelegate?

    var tabbars: [UIViewController] = [] {
        didSet {
            self.viewControllers = tabbars
        }
    }

    var lastSelectIndex: Int = 0

    override public var selectedIndex: Int {
        didSet {
            self.tabBar.withOutAnimationLottieImage(index: selectedIndex)
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        // Do any additional setup after loading the view.
    }

    public func addTabLottieView(jsons: [String]) {
        for index in 0..<tabbars.count {
            self.tabBar.addLottieImage(index: index, lottieName: jsons[index])
            self.tabBar.addRedPointView(index: index)
            self.tabBar.addRedPointLabel(index: index)
        }
    }
}

extension LottieTabBarViewController: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        lottieDelegate?.lottieTabBar(tabBarController, shouldSelect: viewController)
        return true
    }

    override public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = self.tabBar.items, items.contains(item) {
            let array = items as NSArray
            let index = array.index(of: item)
            if index == lastSelectIndex {
                return
            } else {
                lastSelectIndex = index
                self.tabBar.animationLottieImage(index: index)
            }
            lottieDelegate?.lottieTabBar(tabBar, didSelect: item, selectIndex: index)
        }
    }
}
