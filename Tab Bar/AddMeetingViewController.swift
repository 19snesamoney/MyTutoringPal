//
//  AddMeetingViewController.swift
//  Tab Bar
//
//  Created by Madeline Webster on 5/8/18.
//  Copyright © 2018 Sophia Nesamoney. All rights reserved.
//

import UIKit

class AddMeetingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   // var time = TimeCalc()
    var sections = ["Tutor", "Location", "Purpose", "Date"]
    var subtitleList = ["", "", "", ""]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool){
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    //Segue assignment for different view controllers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: sections[indexPath.row], sender: self)
    }
    
    // Unwind Save Button For Purpose
    @IBAction func unwindSaveNewToDo(unwindSegue: UIStoryboardSegue) {
        if let addPurposeVC = unwindSegue.source as? AddPurposeViewController {
            if addPurposeVC.newPurpose.count != 0 {
                subtitleList.remove(at: sections.index(of: "Purpose")!)
                subtitleList.insert(addPurposeVC.newPurpose, at: sections.index(of: "Purpose")!)
            }
        }
    }
    
    // Unwind Save Button For Location
    @IBAction func unwindSaveNewLocation(unwindSegue: UIStoryboardSegue) {
        if let addLocationVC = unwindSegue.source as? AddLocationViewController {
            if addLocationVC.newLocation.count != 0 {
                subtitleList.remove(at: sections.index(of: "Location")!)
                subtitleList.insert(addLocationVC.newLocation, at: sections.index(of: "Location")!)
            }
        }
    }
    
    // Unwind Save Button For Tutor
    @IBAction func unwindSaveNewTutor(unwindSegue: UIStoryboardSegue) {
        if let addTutorVC = unwindSegue.source as? AddTutorViewController {
            if addTutorVC.newTutor.count != 0 {
                subtitleList.remove(at: sections.index(of: "Tutor")!)
                subtitleList.insert(addTutorVC.newTutor, at: sections.index(of: "Tutor")!)
            }
        }
    }
    
    // Unwind Save Button For Date
    @IBAction func unwindSaveNewDate(unwindSegue: UIStoryboardSegue) {
        if let addDateVC = unwindSegue.source as? DateViewController {
            if addDateVC.stringDate.count != 0 {
                subtitleList.remove(at: sections.index(of: "Date")!)
                subtitleList.insert(addDateVC.stringDate, at: sections.index(of: "Date")!)
                
            }
        }
    }
    
    //  Unwind Cancel Button
    @IBAction func unwindCancelNewToDo(unwindSegue: UIStoryboardSegue) {
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNewMeeting" {
            subtitleList = [ subtitleList[0], subtitleList[1], subtitleList[2], subtitleList[3] ]
        }
//        if let dateViewController = segue.destination.childViewControllers.first as? DateViewController {
////                dateViewController.time = self.time
//        }
    }
    
    
    //    Text for table view cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")
        let text = sections[indexPath.row]
        let subtitle = subtitleList[indexPath.row]
        cell!.textLabel?.text = text
        cell!.detailTextLabel?.text = subtitle
        return cell!
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let dateViewController = segue.destination.childViewControllers.first as? DateViewController {
//            //dateViewController.time = self.time
//        }
//
//    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

