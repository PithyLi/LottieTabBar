//
//  UITabBar+Lottie.swift
//  Test
//
//  Created by Jayz Zz on 2018/11/16.
//  Copyright © 2018 Jayz Zz. All rights reserved.
//
import UIKit
import Lottie

let LOTAnimationViewWidth: CGFloat = 35.0
let LOTAnimationViewHeight: CGFloat = 35.0
let RedPointViewWidthAndHeight: CGFloat = 8.0
let RedPointLabelWidthAndHeight: CGFloat = 16.0

extension UITabBar {

    static var lastTag: Int = 0

    // json动画
    func addLottieImage(index: Int, lottieName: String) {
        if Thread.isMainThread {
            self.addLottieImageInMainThread(index: index, lottieName: lottieName)
        } else {
            DispatchQueue.main.async {
                self.addLottieImageInMainThread(index: index, lottieName: lottieName)
            }
        }
    }

    // 红点
    func addRedPointView(index: Int) {
        if Thread.isMainThread {
            self.addRedPointViewInMainThread(index: index)
        } else {
            DispatchQueue.main.async {
                self.addRedPointViewInMainThread(index: index)
            }
        }
    }

    private func addLottieImageInMainThread(index: Int, lottieName: String) {
        let lottieView = LOTAnimationView(name: lottieName)
        let totalW = UIScreen.main.bounds.size.width
        let singleW = totalW / CGFloat(self.items?.count ?? 1)
        let x = ceil(CGFloat(index) * singleW + (singleW - LOTAnimationViewWidth) / 2.0)
        let y:CGFloat = 5.0
        lottieView.frame = CGRect(x: x, y: y, width: LOTAnimationViewWidth, height: LOTAnimationViewHeight)
        lottieView.isUserInteractionEnabled = false
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopAnimation = false
        lottieView.tag = 1000 + index;
        self.addSubview(lottieView)
    }

    private func addRedPointViewInMainThread(index: Int) {
        let redView = UIView()
        let totalW = UIScreen.main.bounds.size.width
        let singleW = totalW / CGFloat(self.items?.count ?? 1)
        let x = ceil(CGFloat(index) * singleW + singleW / 2.0 + LOTAnimationViewWidth / 2.0 - 5.0)
        let y:CGFloat = 5.0
        redView.frame = CGRect(x: x, y: y, width: RedPointViewWidthAndHeight, height: RedPointViewWidthAndHeight)
        redView.backgroundColor = UIColor.red
        redView.layer.cornerRadius = RedPointViewWidthAndHeight / 2.0
        redView.tag = 2000 + index;
        redView.isHidden = true
        self.addSubview(redView)
    }

    // 设置红点状态
    public func setBadgeStatus(index: Int, isHidden: Bool, count: Int = 0) {
        let redView = self.viewWithTag(2000 + index)
        if isHidden {
            redView?.isHidden = true
            self.items?[index].badgeValue = nil
        } else {
            if count > 0 {
                let badgeText = count <= 99 ? "\(count)" : "\(99)+"
                redView?.isHidden = true
                self.items?[index].badgeValue = isHidden == false ? badgeText : nil
            } else {
                redView?.isHidden = false
                self.items?[index].badgeValue = nil
            }
        }
    }

    // 点击动画
    func animationLottieImage(index: Int) {
        stopAnimationAllLottieView()
        if let lottieView = self.viewWithTag(1000 + index) as? LOTAnimationView {
            lottieView.animationProgress = 0.0
            lottieView.play { _ in
                UITabBar.lastTag = 1000 + index
            }
        }
    }

    // 无动画选中
    func withOutAnimationLottieImage(index: Int) {
        guard let items = items, index < items.count else { return }
        stopAnimationAllLottieView()
        if let lottieView = self.viewWithTag(1000 + index) as? LOTAnimationView {
            lottieView.animationProgress = 1.0
        }
    }

    // 停止其他动画
    func stopAnimationAllLottieView() {
        guard let items = self.items else { return }
        var i = 0
        for _ in items {
            if let lottieView = self.viewWithTag(1000 + i) as? LOTAnimationView {
                if UITabBar.lastTag == 1000 + i {
                    lottieView.play(fromProgress: 1.0, toProgress: 0.0) { _ in
                        lottieView.stop()
                    }
                } else {
                    lottieView.stop()
                }
            }
            i += 1
        }
    }
}
