//
//  ViewController.swift
//  LottieTabBar
//
//  Created by Jayz Zz on 2018/11/16.
//  Copyright © 2018 Pithy'L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = TestTabbarViewController()
        self.addChild(vc)
        self.view.addSubview(vc.view)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

