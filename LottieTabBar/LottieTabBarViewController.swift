//
//  LottieTabBarViewController.swift
//  Test
//
//  Created by Jayz Zz on 2018/11/13.
//  Copyright © 2018 Jayz Zz. All rights reserved.
//

import UIKit

public protocol LottieTabBarDelegate: class {

    func lottieTabBar(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController)

    func lottieTabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem, selectIndex: Int)
}

open class LottieTabBarViewController: UITabBarController {

    public weak var lottieDelegate: LottieTabBarDelegate?

    public var tabbars: [UIViewController] = [] {
        didSet {
            self.viewControllers = tabbars
        }
    }

    var lastSelectIndex: Int = 0

    override open var selectedIndex: Int {
        didSet {
            self.tabBar.withOutAnimationLottieImage(index: selectedIndex)
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        // Do any additional setup after loading the view.
    }

    public func addTabLottieView(jsons: [String], titles: [String]? = nil) {
        for index in 0..<tabbars.count {
            guard index < jsons.count else { return }
            self.tabBar.addLottieImage(index: index, lottieName: jsons[index])
            self.tabBar.addRedPointView(index: index)
            if let titles = titles, index < titles.count {
                self.tabBar.items?[index].title = titles[index]
            } else {
                self.tabBar.items?[index].title = ""
                self.tabBar.items?[index].titlePositionAdjustment = UIOffset(horizontal: 15.0, vertical: 0.0)
            }
        }
    }
}

extension LottieTabBarViewController: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        lottieDelegate?.lottieTabBar(tabBarController, shouldSelect: viewController)
        return true
    }

    override open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
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
