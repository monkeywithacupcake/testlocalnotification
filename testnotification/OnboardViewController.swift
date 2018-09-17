//
//  OnboardViewController.swift
//  testnotification
//
//  Created by Jess Chandler on 9/17/18.
//  Copyright © 2018 Jess Chandler. All rights reserved.
//

import UIKit
//import SwiftyOnboard

class OnboardViewController: UIViewController {

    var swiftyOnboard: SwiftyOnboard!
    let colors:[UIColor] = [#colorLiteral(red: 0.9980840087, green: 0.3723873496, blue: 0.4952875376, alpha: 1),#colorLiteral(red: 0.2666860223, green: 0.5116362572, blue: 1, alpha: 1),#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)]
    let pages = 3
    var titleArray: [String] = ["Welcome to TestNotification!", "You can test a notification", "Push a button"]
    var subTitleArray: [String] = ["TestNotification lets you \n yes, you!\n push a button \n to get a local notification", "It is super easy\n Just a trigger", "See the source code \n on github for details :)"]

    var gradiant: CAGradientLayer = {
        //Gradiant for the background view
        let green = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0).cgColor
        let grey = UIColor(red: 118/255, green: 137/255, blue: 118/255, alpha: 1.0).cgColor
        let gradiant = CAGradientLayer()
        gradiant.colors = [green, grey]
        gradiant.startPoint = CGPoint(x: 0.5, y: 0.18)
        return gradiant
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        gradient()
        UIApplication.shared.statusBarStyle = .lightContent

        swiftyOnboard = SwiftyOnboard(frame: view.frame, style: .light)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self as SwiftyOnboardDataSource
        swiftyOnboard.delegate = self as SwiftyOnboardDelegate
    }

    func gradient() {
        //Add the gradiant to the view:
        self.gradiant.frame = view.bounds
        view.layer.addSublayer(gradiant)
    }

    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }

    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag

        // if it is the last one, go to Main, else next
        if(index==pages-1){
            goToMain()
        } else {
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }

    }

    func goToMain() {
        let detailVC: ButtonViewController? = ButtonViewController()
        if detailVC != nil {
            detailVC?.modalPresentationStyle = .fullScreen
            let navigationController = UINavigationController(rootViewController: detailVC!)
            present(navigationController, animated: true, completion: nil)
        }
    }
}

extension OnboardViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {

    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return pages
    }

//    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
//        //Return the background color for the page at index:
//        return colors[index]
//
//    }

    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()

        //Set the image on the page:
        view.imageView.image = UIImage(named: "onboard\(index)")

        //Set the font and color for the labels:
        view.title.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)//UIFont(name: "Lato-Heavy", size: 22)
        view.subTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)//UIFont(name: "Lato-Regular", size: 16)

        //Set the text in the page:
        view.title.text = titleArray[index]
        view.subTitle.text = subTitleArray[index]

        //Return the page for the given index:
        return view
    }

    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()

        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)

        //Setup for the overlay buttons:
        overlay.continueButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.largeTitle) //UIFont(name: "Lato-Bold", size: 16)
        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
        overlay.skipButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)//UIFont(name: "Lato-Heavy", size: 16)

        //Return the overlay view:
        return overlay
    }

    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)

        if (currentPage < Double(pages)) {
            overlay.continueButton.setTitle("Continue", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = false
        } else {
            overlay.continueButton.setTitle("Get Started!", for: .normal)
            overlay.skipButton.isHidden = true
        }
    }
}
