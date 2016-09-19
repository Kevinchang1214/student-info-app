//
//  StudentInformation.swift
//  KevinChangHw2
//
//  Created by Kevin Chang on 9/10/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

protocol StudentInformation{
    
    var name: String{get}
    var hometown: String{get}
    var degree: String{get}
    var gender: Character{get}
    var programmingLanguages: Array<String>{get}
    var hobbies: Array<String>{get}
    
}
