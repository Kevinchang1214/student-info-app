//
//  Student.swift
//  KevinChangHw2
//
//  Created by Kevin Chang on 9/10/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import Foundation
import UIKit

struct Student: StudentInformation{
    
    var name: String
    var hometown: String
    var degree: String
    var gender: Character
    var familyMembers: Int
    var programmingLanguages: Array<String>
    var hobbies: Array<String>
    var futureGoals: Array<String>
    
    var photo:UIImage
    
}

struct PropertyKey{
    static let nameKey = "name"
    static let hometownKey = "hometown"
    static let degreeKey = "degree"
    static let genderKey = "gender"
    static let siblingKey = "familyMembers"
    static let languageKey = "programmingLanguages"
    static let hobbyKey = "hobbies"
    static let careerKey = "futureGoals"
    static let photoKey = "photo"
}

