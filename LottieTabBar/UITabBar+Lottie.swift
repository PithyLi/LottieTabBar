//
//  UITabBar+Lottie.swift
//  Test
//
//  Created by Jayz Zz on 2018/11/16.
//  Copyright © 2018 Jayz Zz. All rights reserved.
//
import UIKit
import Lottie

let LOTAnimationViewWidth: CGFloat = 40.0
let LOTAnimationViewHeight: CGFloat = 40.0
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

    // 消息数红点
    func addRedPointLabel(index: Int) {
        if Thread.isMainThread {
            self.addRedPointLabelInMainThread(index: index)
        } else {
            DispatchQueue.main.async {
                self.addRedPointLabelInMainThread(index: index)
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

    private func addRedPointLabelInMainThread(index: Int) {
        let redLabel = UILabel()
        let totalW = UIScreen.main.bounds.size.width
        let singleW = totalW / CGFloat(self.items?.count ?? 1)
        let x = ceil(CGFloat(index) * singleW + singleW / 2.0 + LOTAnimationViewWidth / 2.0 - 5.0)
        let y:CGFloat = 3.0
        redLabel.frame = CGRect(x: x, y: y, width: RedPointLabelWidthAndHeight, height: RedPointLabelWidthAndHeight)
        redLabel.backgroundColor = UIColor.red
        redLabel.layer.masksToBounds = true
        redLabel.layer.cornerRadius = RedPointLabelWidthAndHeight / 2.0
        redLabel.tag = 3000 + index;
        redLabel.textColor = UIColor.white
        redLabel.textAlignment = .center
        redLabel.font = UIFont.systemFont(ofSize: 10.0)
        redLabel.isHidden = true
        self.addSubview(redLabel)
    }

    // 设置红点状态
    func setRedPointViewStatus(index: Int, isHidden: Bool) {
        let redView = self.viewWithTag(2000 + index)
        if let redLabel = self.viewWithTag(3000 + index) as? UILabel {
            redLabel.isHidden = true
        }
        redView?.isHidden = isHidden
    }

    // 设置消息数红点状态
    func setRedPointLabelStatus(index: Int, isHidden: Bool, count: Int) {
        if let redLabel = self.viewWithTag(3000 + index) as? UILabel {
            redLabel.isHidden = isHidden
            let text = count <= 99 ? "\(count)" : "\(99)+"
            redLabel.text = text
            redLabel.sizeToFit()
            let width = redLabel.frame.size.width + 6.0 > RedPointLabelWidthAndHeight ? redLabel.frame.size.width + 6.0 : RedPointLabelWidthAndHeight
            redLabel.frame = CGRect(x: redLabel.frame.origin.x, y: redLabel.frame.origin.y, width: width, height: RedPointLabelWidthAndHeight)
            let redView = self.viewWithTag(2000 + index)
            redView?.isHidden = true
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
