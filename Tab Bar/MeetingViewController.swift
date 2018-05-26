//
//  FirstViewController.swift
//  Tab Bar
//
//  Created by Sophia Nesamoney on 3/22/18.
//  Copyright © 2018 Sophia Nesamoney. All rights reserved.
// This is Madeline!
import UIKit

class MeetingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    var sections: [Section] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var defaultMeetingNumber: Int = 1
    
    //  Make edit button work
    @IBAction func edit(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
        switch tableView.isEditing {
        case true:
            editButton.title = "Done"
        case false:
            editButton.title = "Edit"
        }
    }
    
    //Allows reordering of table cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = sections[sourceIndexPath.section]
        sections.remove(at: sourceIndexPath.section)
        sections.insert(item, at: destinationIndexPath.section)
        let defaults = UserDefaults.standard
        defaults.set(sections, forKey: "NewMeeting")
    }
    
    //Delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            sections.remove(at: indexPath.section)
            tableView.reloadData()
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(sections) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "NewMeeting")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let defaults = UserDefaults.standard
        if let savedSections = defaults.object(forKey: "NewMeeting") as? Data {
            let decoder = JSONDecoder()
            if let loadedSections = try? decoder.decode([Section].self, from: savedSections) {
                sections = loadedSections
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    //Unwind Save
    @IBAction func unwindSaveNewMeeting(unwindSegue: UIStoryboardSegue) {
        if let newMeetingVC = unwindSegue.source as? AddMeetingViewController {
            if newMeetingVC.subtitleList.count != 0 {
                if newMeetingVC.subtitleList != [""] {
                    var purpose: String = newMeetingVC.subtitleList[2]
                    if (purpose == "") {
                        purpose = "Meeting \(defaultMeetingNumber)"
                        defaultMeetingNumber += 1
                    }
                    sections.append(Section(purpose: purpose, location: newMeetingVC.subtitleList[1], tutor: newMeetingVC.subtitleList[0], time: newMeetingVC.subtitleList[3], expanded: false))
                    
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(sections) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "NewMeeting")
                    }
                    //sections.append(Section(purpose: "purpose", location: "location", tutor: "tutor", time: "time", expanded: false))
        

                    
                    
                   
                }
                
                
            }
        }
    }
    //segue?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    //TODO
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCountPerSection: Int = 0
        let currentSection: Section = sections[section]
        let toDisplay: [String] = [ currentSection.time, currentSection.location, currentSection.tutor ]
        for i in 0 ..< toDisplay.count {
            if toDisplay[i] != "" {
                rowCountPerSection += 1
            }
        }
        return rowCountPerSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        let currentSection: Section = sections[indexPath.section]
        var toDisplay: [String] = []
        if (currentSection.time != "") {
            toDisplay.append(currentSection.time)
        }
        if (currentSection.location != "") {
            toDisplay.append(currentSection.location)
        }
        if (currentSection.tutor != "") {
            toDisplay.append(currentSection.tutor)
        }
        cell.textLabel?.text = toDisplay[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.beginUpdates()
        let currentSection: Section = sections[section]
        var toDisplay: [String] = []
        if (currentSection.time != "") {
            toDisplay.append(currentSection.time)
        }
        if (currentSection.location != "") {
            toDisplay.append(currentSection.location)
        }
        if (currentSection.tutor != "") {
            toDisplay.append(currentSection.tutor)
        }
        for i in 0 ..< toDisplay.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].purpose, section: section, delegate: self)
        return header
    }
    
    
    // Layout Measurements
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 44
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


