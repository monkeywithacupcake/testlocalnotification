//
//  ViewController.swift
//  testnotification
//
//  Created by Jess Chandler on 9/14/18.
//  Copyright © 2018 Jess Chandler. All rights reserved.
//

import UIKit
import UserNotifications // THIS IS IMPORTANT

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnTapped(_ sender: UIButton) {

        let content = UNMutableNotificationContent()
        // content.title = "Tapper: YOU DO NOT NEED THIS"
        content.body = "You tapped a button 3 seconds ago"
        // content.subtitle = "Subtitle: YOU DO NOT NEED THIS"

        // set up the trigger - this can be UNCalendarNotificationTrigger, UNTimeIntervalNotificationTrigger, or UNLocationNotificationTrigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (3), repeats: false)
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.getNotificationSettings { (settings) in
            // Do not schedule notifications if not authorized.
            guard settings.authorizationStatus == .authorized else {return}

            notificationCenter.add(request) { (error) in
                if error != nil {
                    // Handle any errors.
                    print(error as Any)
                }
            }
        }
    }





}

