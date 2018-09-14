//
//  ViewController.swift
//  testnotification
//
//  Created by Jess Chandler on 9/14/18.
//  Copyright © 2018 Jess Chandler. All rights reserved.
//

import UIKit
import UserNotifications // THIS IS IMPORTANT - ALSO SEE DELEGATE

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnTapped(_ sender: UIButton) {
        // if someone taps our button, this happens

        // create our notification content

        let content = UNMutableNotificationContent()
        content.title = "Tapper"
        content.body = "You tapped a button 2 seconds ago"

        // set up the trigger - this can be UNCalendarNotificationTrigger, UNTimeIntervalNotificationTrigger, or UNLocationNotificationTrigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (3), repeats: false)
        print(trigger)
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)

        print(request)
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
                print(error as Any)
            }
        }

    }

    // UNNotification Delegate Methods

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.badge])
    }



}

