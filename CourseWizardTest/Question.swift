//
//  Question.swift
//  CourseWizardTest
//
//  Created by Thomas Clifford on 4/11/17.
//  Copyright © 2017 coursewizard. All rights reserved.
//

import UIKit
import Parse

class Question: NSObject {
    
    var id: String?
    var text: String?
    var courseID: String?
    
    init(question: PFObject) {
        super.init()
        self.id = question.objectId
        self.text = question["text"] as? String
        self.courseID = question["courseID"] as? String
    }
    
    func getAnswers(success: @escaping ([Answer])->()) {
        let query = PFQuery(className: "Answer")
        
        if let id = id {
            query.whereKey("questionID", equalTo: id)
        }
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let objects = objects {
                var answersArray: [Answer] = []
                for object in objects {
                    answersArray.append(Answer(answer: object))
                }
                success(answersArray)
            }
            else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func postAnswer(text: String, success: @escaping ()->()) {
        let answer = PFObject(className: "Question")
        
        // Add relevant fields to the object
        
        answer["text"] = text
        answer["questionID"] = id
        
        answer.saveInBackground { (done: Bool, error: Error?) in
            if(done) {
                success()
            }
        }
    }
    
    
}
