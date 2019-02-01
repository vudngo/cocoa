//
//  ViewController.swift
//  sentry-ios-cocoapods
//
//  Created by Daniel Griesser on 18.07.17.
//  Copyright © 2017 Sentry. All rights reserved.
//

import UIKit
import Sentry

class ViewController: UIViewController {    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            Client.shared = try Client(dsn: "https://bb83b7178b7b46aa96f69eb77d2038b2@sentry.io/1385152")
            try Client.shared?.startCrashHandler()
            Client.logLevel = .verbose
            Client.shared?.tags = ["a": "b"]
            Client.shared?.extra = ["c": "d"]
            let user = User(userId: "1234")
            user.email = email.text!
            Client.shared?.user = user
        } catch let error {
            print("\(error)")
            // Wrong DSN or KSCrash not installed
        }
        Client.shared?.enableAutomaticBreadcrumbTracking()
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let event = Event(level: .debug)
        event.message = "This is a custom event"
        Client.shared?.send(event: event) { (error) in
            // Optional callback after event has been send
        }
        var n = 10
        var d = 0
        while d <= 10 {
            n/d
            d=d+1
        }
    }
    
    @IBAction func causeCrash(_ sender: Any) {
        Client.shared?.crash()
    }
    
    @IBOutlet weak var display: UITextView!
    
    @IBOutlet weak var email: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        display.text = "Hello, " + email.text! + "!"
        let user = User(userId: "6789")
        user.email = email.text!
        Client.shared?.user = user
    }
}

