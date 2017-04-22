//
//  School.swift
//  CourseWizardTest
//
//  Created by Thomas Clifford on 4/10/17.
//  Copyright © 2017 coursewizard. All rights reserved.
//

import UIKit
import Parse

class School: NSObject {

    var id: String?
    var name: String?
    

    func getDepartments(success: @escaping ([Department])->()) {
        
        let query = PFQuery(className: "Department")
    
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                var departmentsArray: [Department] = []
                for object in objects {
                    departmentsArray.append(Department(department: object))
                }
                success(departmentsArray)
            }
            else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    static func addTestSchool(name: String, success: @escaping ()->()) {
        let school = PFObject(className: "School")
        
        // Add relevant fields to the object
        
        school["name"] = name
        
        school.saveInBackground { (done: Bool, error: Error?) in
            if(done) {
                success()
            }
        }
    }
    
    func addTestDepartment(name: String, abbreviation: String,  success: @escaping ()->()) {
        let department = PFObject(className: "Department")
        
        department["name"] = name
        department["abbreviation"] = abbreviation
        department["schoolID"] = id
        
        department.saveInBackground { (done: Bool, error: Error?) in
            if(done) {
                success()
            }
        }
    }
    
    
}
