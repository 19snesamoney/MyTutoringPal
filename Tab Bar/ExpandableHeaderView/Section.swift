//
//  Section.swift
//  TableViewDropDown
//
//  Created by Sophia Nesamoney on 4/30/18.
//  Copyright © 2018 Sophia Nesamoney. All rights reserved.
//

import Foundation
struct Section {
    var purpose: String!
    var location: String!
    var tutor: String!
    var time: String!
    var expanded: Bool!

    init (purpose: String!, location: String!, tutor: String!, time: String!, expanded: Bool!) {
        self.purpose = purpose
        self.location = location
        self.tutor = tutor
        self.time = time
        self.expanded = expanded
    }
}
