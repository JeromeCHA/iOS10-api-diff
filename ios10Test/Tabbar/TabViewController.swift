//
//  TabViewController.swift
//  ios10Test
//
//  Created by ジェローム　チャ on 2018/07/19.
//  Copyright © 2018 ジェローム　チャ. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {

    @IBOutlet weak var titleFontSizeSlider: UISlider!
    @IBOutlet weak var titleRedSlider: UISlider!
    @IBOutlet weak var titleGreenSlider: UISlider!
    @IBOutlet weak var titleBlueSlider: UISlider!

    @IBOutlet weak var badgeTitleFontSizeSlider: UISlider!
    @IBOutlet weak var badgeTitleRedSlider: UISlider!
    @IBOutlet weak var badgeTitleGreenSlider: UISlider!
    @IBOutlet weak var badgeTitleBlueSlider: UISlider!

    @IBOutlet weak var badgeBackgroundRedSlider: UISlider!
    @IBOutlet weak var badgeBackgroundGreenSlider: UISlider!
    @IBOutlet weak var badgeBackgroundBlueSlider: UISlider!


    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.items?.first?.badgeValue = "123"
        tabBarController?.tabBar.items?.last?.badgeValue = "TEXT"
        updateTabbar()
    }

    @IBAction func changedSlider() {
        updateTabbar()
    }

    func updateTabbar() {
        tabBarController?.tabBar.items?.first?.setBadgeTextAttributes([
            NSAttributedStringKey.foregroundColor.rawValue: UIColor(red: CGFloat(badgeTitleRedSlider.value),
                                                                    green: CGFloat(badgeTitleGreenSlider.value),
                                                                    blue: CGFloat(badgeTitleBlueSlider.value),
                                                                    alpha: 1),
            NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: CGFloat(badgeTitleFontSizeSlider.value))
            ], for: .normal)
        tabBarController?.tabBar.items?.first?.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor(red: CGFloat(titleRedSlider.value),
                                                           green: CGFloat(titleGreenSlider.value),
                                                           blue: CGFloat(titleBlueSlider.value),
                                                           alpha: 1),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(titleFontSizeSlider.value))
            ], for: .normal)
        tabBarController?.tabBar.items?.first?.badgeColor = UIColor(red: CGFloat(badgeBackgroundRedSlider.value),
                                                                    green: CGFloat(badgeBackgroundGreenSlider.value),
                                                                    blue: CGFloat(badgeBackgroundBlueSlider.value),
                                                                    alpha: 1)
    }
}
