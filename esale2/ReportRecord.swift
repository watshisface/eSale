//
//  ReportRecord.swift
//  esale2
//
//  Created by Marvin Manzi on 5/27/15.
//  Copyright (c) 2015 Marvin Manzi. All rights reserved.
//

import UIKit
import CoreData

class ReportRecord: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var receiver: String
    @NSManaged var amount: Int
    @NSManaged var time: String
    @NSManaged var icon: String
    
    

}
