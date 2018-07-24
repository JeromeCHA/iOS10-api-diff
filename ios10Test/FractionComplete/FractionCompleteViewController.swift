//
//  FractionCompleteViewController.swift
//  ios10Test
//
//  Created by ジェローム　チャ on 2018/07/24.
//  Copyright © 2018 ジェローム　チャ. All rights reserved.
//

import UIKit

class FractionCompleteViewController: UIViewController {
    @IBOutlet weak var smirkLabel: UILabel!

    var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // FractionComplete Demo
        animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear){
            self.smirkLabel.center = CGPoint(x: self.smirkLabel.superview!.frame.maxX - self.smirkLabel.frame.width / 2, y: self.smirkLabel.frame.origin.y + self.smirkLabel.frame.height / 2)
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.animator?.fractionComplete = CGFloat(sender.value)
    }
}
