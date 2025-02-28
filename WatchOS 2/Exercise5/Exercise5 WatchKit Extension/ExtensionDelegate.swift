//
//  ExtensionDelegate.swift
//  Exercise5 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 20/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        do {
            let filePath = NSBundle.mainBundle().pathForResource("schedule", ofType: "json")
            let data = NSData(contentsOfFile: filePath!)
            ScheduleTV().schedule = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? Dictionary<String, AnyObject>
        } catch let error as NSError {
            print("JSON Error: \(error.localizedDescription)")
        }
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
