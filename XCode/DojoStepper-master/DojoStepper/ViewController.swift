//
//  ViewController.swift
//  DojoStepper
//
//  Created by Daniel Thompson on 3/9/17.
//  Copyright © 2017 Daniel Thompson. All rights reserved.
//

import UIKit
import CoreMotion

let activityManager = CMMotionActivityManager()
let activity = CMMotionActivity()
let activityArray = [CMMotionActivity]()

let pedoManager = CMPedometer()
let pedoData = CMPedometerData()
let pedoArray = [CMPedometerData]()

var pedoTimeStart:Date = Date()
var pedoTimeStop:Date = Date()
var pedoTimeElapsed:TimeInterval = 0

class ViewController: UIViewController {

    //Instance Variables
    
    //Outlets
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var pedoStepsLabel: UILabel!
    @IBOutlet weak var pedoDistanceLabel: UILabel!
    @IBOutlet weak var pedoTimeLabel: UILabel!
    
    // Init Function
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Button Actions
    @IBAction func StartButton(_ sender: UIButton) {
        self.startActivityCurrent()
        self.startPedometer()
    }
    
    @IBAction func StopButton(_ sender: UIButton) {
        self.stopActivityCurrent()
        self.stopPedometer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startActivityCurrent() {
        if (CMMotionActivityManager.isActivityAvailable()) {
            activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: { (activity:CMMotionActivity?) in
                self.displayActivity(activity:activity!)
            })
            print("Start Activity")
        }
    }

    func stopActivityCurrent() {
        activityManager.stopActivityUpdates()
        print("Stop Activity")
        }

    func displayActivity(activity:CMMotionActivity) {
        var activityText:String = ""

        print("New Activity \(activity)")
        if activity.stationary==true {
            activityText = "Sitting"
        }
        else if activity.walking==true {
            activityText = "Walking"
        }
        else if activity.running==true {
            activityText = "Running"
        }
        else if activity.cycling==true {
            activityText = "Cycling"
        }
        else if activity.automotive==true {
            activityText = "Driving"
        }
        else {
            activityText = "Unknown"
        }
        self.activityLabel.text = activityText
    }

    func startPedometer() {
        pedoTimeStart = Date()
        pedoManager.startUpdates(from:pedoTimeStart, withHandler: { (pedoData:CMPedometerData?, Error) in
            if Error == nil {
                self.displayPedo(pedoData:pedoData!)
            }
        })
        print("Start Pedo")
    }

    func stopPedometer() {
        pedoManager.stopUpdates()
        print("Stop Pedo")
    }
    
    func displayPedo(pedoData:CMPedometerData!) {
        print("New PedoData \(pedoData)")
        if CMPedometer.isStepCountingAvailable() {
            self.pedoStepsLabel.text = "\(pedoData.numberOfSteps)"
            print("Steps= \(pedoData.numberOfSteps)")
        }
        if CMPedometer.isDistanceAvailable() {
            let distance = (Double(pedoData.distance!)).rounded(.down)
            self.pedoDistanceLabel.text = "\(distance) m"
            print("Dist= \(pedoData.distance)")
        }
        pedoTimeStop = Date()
        pedoTimeElapsed = pedoTimeStop.timeIntervalSince(pedoTimeStart)
        let hours = (pedoTimeElapsed / 3600.0).rounded(.down)
        let minutes = ((pedoTimeElapsed / 60).truncatingRemainder(dividingBy:60)).rounded(.down)
        let seconds = (pedoTimeElapsed.truncatingRemainder(dividingBy: 60)).rounded(.down)
        let timeString = "\(hours):\(minutes):\(seconds)"
        self.pedoTimeLabel.text = timeString
//        self.pedoTimeLabel.text = NSString(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds) as String
        print("Time= \(pedoTimeElapsed) \(timeString)")
    }
}


//    func startActivityRecord() {
//        if (CMMotionActivityManager.isActivityAvailable()) {
//            activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: { activity in })
//        activityTimeStart = Date()
//        }
//    }
//
//    func stopActivityRecord() {
//        activityTimeStop = Date()
//        activityManager.stopActivityUpdates()
//        activityManager.queryActivityStarting(from:activityTimeStart, to:activityTimeStop, to:OperationQueue.main, withHandler: { (activityArray?, Error) in
//            if Error == nil {
//                displayActivityQueue(activityArray:activityArray!)
//            }
//        })
//    }
//
//
//    func displayActivityQueue(activityArray:[CMMotionActivity]) {
//
//        for activity in activityArray {
//        }
//    }

