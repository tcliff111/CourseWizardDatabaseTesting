//
//  Review.swift
//  CourseWizardTest
//
//  Created by Thomas Clifford on 4/11/17.
//  Copyright © 2017 coursewizard. All rights reserved.
//

import UIKit
import Parse

class Review: NSObject {
    
    var id: String?
    var text: String?
    var teacher: String?
    var upvotes: Int? = 0
    var courseID: String?
    
    init(review: PFObject) {
        super.init()
        self.id = review.objectId
        self.text = review["text"] as? String
        self.teacher = review["teacher"] as? String
        self.courseID = review["courseID"] as? String
        self.upvotes = review["upvotes"] as? Int
    }
    
//    init(text: String?, teacher: String?) {
//        super.init()
//        self.id = review.objectId
//        self.text = text
//        self.teacher = teacher
//    }
    
}
