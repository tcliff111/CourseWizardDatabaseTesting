//
//  Answer.swift
//  CourseWizardTest
//
//  Created by Thomas Clifford on 4/11/17.
//  Copyright © 2017 coursewizard. All rights reserved.
//

import UIKit
import Parse

class Answer: NSObject {
    
    var id: String?
    var text: String?
    var questionID: String?
    
    init(answer: PFObject) {
        super.init()
        self.id = answer.objectId
        self.text = answer["text"] as? String
        self.questionID = answer["questionID"] as? String
    }
    
}
