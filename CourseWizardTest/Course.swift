//
//  Course.swift
//  CourseWizardTest
//
//  Created by Thomas Clifford on 4/11/17.
//  Copyright © 2017 coursewizard. All rights reserved.
//

import UIKit
import Parse

class Course: NSObject {
    
    var id: String?
    var name: String?
    var number: String?
    var descript: String?
    var departmentID: String?

    init(course: PFObject) {
        super.init()
        self.id = course.objectId
        self.name = course["name"] as? String
        self.number = course["number"] as? String
        self.descript = course["descript"] as? String
        self.departmentID = course["departmentID"] as? String
    }
    
    func getReviews(success: @escaping ([Review])->()) {
        let query = PFQuery(className: "Review")
        
        if let id = id {
            query.whereKey("courseID", equalTo: id)
        }
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                var reviewsArray: [Review] = []
                for object in objects {
                    reviewsArray.append(Review(review: object))
                }
                success(reviewsArray)
            }
            else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func getQuestions(success: @escaping ([Question])->()) {
        let query = PFQuery(className: "Question")
        
        if let id = id {
            query.whereKey("courseID", equalTo: id)
        }
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                var questionsArray: [Question] = []
                for object in objects {
                    questionsArray.append(Question(question: object))
                }
                success(questionsArray)
            }
            else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func postReview(text: String, teacher: String, success: @escaping ()->()) {
        let review = PFObject(className: "Review")
        
        // Add relevant fields to the object
        
        review["text"] = text
        review["teacher"] = teacher
        review["upvotes"] = 0
        review["courseID"] = id

        review.saveInBackground { (done: Bool, error: Error?) in
            if(done) {
                success()
            }
        }
    }
    
    func postQuestion(text: String, success: @escaping ()->()) {
        let question = PFObject(className: "Question")
        
        // Add relevant fields to the object
        
        question["text"] = text
        question["courseID"] = id
        
        question.saveInBackground { (done: Bool, error: Error?) in
            if(done) {
                success()
            }
        }
    }
    
}




