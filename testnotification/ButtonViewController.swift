//
//  ViewController.swift
//  testnotification
//
//  Created by Jess Chandler on 9/14/18.
//  Copyright © 2018 Jess Chandler. All rights reserved.
//

import UIKit
import UserNotifications // THIS IS IMPORTANT

class ButtonViewController: UIViewController{

    var tapButton = UIButton()

    // MARK: - Lifecycle
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //recommendation is to do thiw with app delegate..however, now we have an onboarding, so we do this after
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (permissionGranted, error) in
            print(error as Any)
        }
    }

    // MARK: Setup
    func setupView() {
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        tapButton.setTitle("Click Me", for: .normal)
        tapButton.backgroundColor = UIColor.black
        tapButton.setTitleColor(UIColor.white, for: .normal)
        tapButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        self.view.addSubview(tapButton)
        tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tapButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 0).isActive = true
        tapButton.addTarget(self, action:#selector(btnTapped), for: UIControlEvents.touchUpInside)
    }


    // MARK: Actions
    @objc func btnTapped(_ sender: UIButton) {

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
