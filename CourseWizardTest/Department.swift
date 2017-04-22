//
//  Department.swift
//  CourseWizardTest
//
//  Created by Thomas Clifford on 4/11/17.
//  Copyright © 2017 coursewizard. All rights reserved.
//

import UIKit
import Parse

class Department: NSObject {
    
    var id: String?
    var name: String?
    var abbreviation: String?
    var schoolID: String?

    init(department: PFObject) {
        super.init()
        self.id = department.objectId
        self.name = department["name"] as? String
        self.abbreviation = department["abbreviation"] as? String
        self.schoolID = department["schoolID"] as? String
    }
    
    
    func getCourses(success: @escaping ([Course])->()) {
        
        let query = PFQuery(className: "Course")
        
        if let id = id {
            query.whereKey("departmentID", equalTo: id)
        }
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                var coursesArray: [Course] = []
                for object in objects {
                    coursesArray.append(Course(course: object))
                }
                success(coursesArray)
            }
            else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func addTestCourse(name: String, number: String, descript: String,  success: @escaping ()->()) {
        let course = PFObject(className: "Course")
        
        course["name"] = name
        course["number"] = number
        course["descript"] = descript
        course["departmentID"] = id
        
        course.saveInBackground { (done: Bool, error: Error?) in
            if(done) {
                success()
            }
        }
    }
    
    static func getDepartmentWithID(id: String,   success: @escaping (Department)->()) {
        let query = PFQuery(className: "Department")
        
        query.getObjectInBackground(withId: id) { (obj: PFObject?, error: Error?) in
            if let obj = obj {
                let department = Department(department: obj)
                success(department)
            }
        }
        
    }
}
