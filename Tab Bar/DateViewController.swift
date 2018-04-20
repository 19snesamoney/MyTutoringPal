//
//  DateViewController.swift
//  Tab Bar
//
//  Created by Sreya Guha on 3/27/18.
//  Copyright © 2018 Sophia Nesamoney. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    var datePicker = UIDatePicker()
    var time = Date()
    @IBOutlet weak var meetingPicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alertsViewController = segue.destination as? AlertsViewController {
            alertsViewController.time = self.time
        }
        
    }
    
    @IBAction func meetingAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        let meetingTime = meetingPicker.date
        meetingTime.timeIntervalSinceNow

        let defaults = UserDefaults.standard
        let meeting = defaults.integer(forKey: "meetingTime")
       

       // var StringDate = dateFormatter.string(from: datePicker.date)
        
        
    }
    
        
        //
}

