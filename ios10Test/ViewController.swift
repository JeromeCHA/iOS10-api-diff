//
//  ViewController.swift
//  ios10Test
//
//  Created by ジェローム　チャ on 2018/07/18.
//  Copyright © 2018 ジェローム　チャ. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var prefetchingSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!

    private let center =  UNUserNotificationCenter.current()


    override func viewDidLoad() {
        super.viewDidLoad()
        //requesting for authorization
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prefetchingViewController = segue.destination as? PrefetchingCollectionViewController {
            prefetchingViewController.isPrefetchingEnable = prefetchingSwitch.isOn
        }
    }

    // Notifications
    @IBAction func tappedNotification(_ sender: Any) {
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        content.sound = UNNotificationSound.default()

        var url = Bundle.main.url(forResource: "space",
                                  withExtension: "jpg")
        if notificationSwitch.isOn {
            url = Bundle.main.url(forResource: "notification",
                                  withExtension: "mov")
        }
        if let url = url {
            if let attachment = try? UNNotificationAttachment(identifier:
                "image", url: url, options: nil) {
                content.attachments = [attachment]
            }
        }

        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:0.5, repeats: false)

        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)

        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
}
