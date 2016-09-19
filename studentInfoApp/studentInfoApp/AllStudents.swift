//
//  AllStudents.swift
//  KevinChangHw2
//
//  Created by Kevin Chang on 9/10/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import Foundation
import UIKit

class AllStudents:NSObject,NSCoding{
    
    
    var studentNames = [String:Student]()
    var newStudent:Student!
    static let collectionKey = "collectionKekgky"
    //NSCoding inherited methods
  
    //Adapted from apple developer tutorials
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let hometown = aDecoder.decodeObjectForKey(PropertyKey.hometownKey) as! String
        let degree = aDecoder.decodeObjectForKey(PropertyKey.degreeKey) as! String
        let gender = aDecoder.decodeObjectForKey(PropertyKey.genderKey) as! String
        let sibling = aDecoder.decodeIntegerForKey(PropertyKey.siblingKey)
        let languages = aDecoder.decodeObjectForKey(PropertyKey.languageKey) as! [String]
        let hobbies = aDecoder.decodeObjectForKey(PropertyKey.hobbyKey) as! [String]
        let careers = aDecoder.decodeObjectForKey(PropertyKey.careerKey) as! [String]
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        print("decoded")
        
  
        
        self.init()
        self.addStudent(name, studentHometown:hometown, studentDegree:degree, studentGender:Character(gender), studentFamilyMembers: sibling, studentProgrammingLanguages:languages,studentHobbies:hobbies, studentGoals:careers, studentPhoto:photo!)
    }
    
    //Mark: Archiving paths, adapted from apple developer tutorials
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("studentNames")
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(newStudent.name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(newStudent.hometown, forKey: PropertyKey.hometownKey)
        aCoder.encodeObject(newStudent.degree, forKey: PropertyKey.degreeKey)
        aCoder.encodeObject(String(newStudent.gender), forKey: PropertyKey.genderKey)
        aCoder.encodeInteger(newStudent.familyMembers, forKey: PropertyKey.siblingKey)
        aCoder.encodeObject(newStudent.programmingLanguages, forKey: PropertyKey.languageKey)
        aCoder.encodeObject(newStudent.hobbies, forKey: PropertyKey.hobbyKey)
        aCoder.encodeObject(newStudent.futureGoals, forKey: PropertyKey.careerKey)
        aCoder.encodeObject(newStudent.photo, forKey: PropertyKey.photoKey)
        
        
    }
    


/**
 add a student based on their name and information
 **/
    func addStudent(studentName:String, studentHometown:String, studentDegree:String, studentGender:Character, studentFamilyMembers: Int, studentProgrammingLanguages:Array<String>,studentHobbies:Array<String>, studentGoals:Array<String>, studentPhoto:UIImage){
    
        let newStudent = Student(name: studentName, hometown: studentHometown, degree: studentDegree, gender: studentGender, familyMembers:studentFamilyMembers, programmingLanguages:studentProgrammingLanguages,hobbies:studentHobbies, futureGoals:studentGoals,photo:studentPhoto)
    
    studentNames[studentName] = newStudent
}
    
    func addStudent(currStu:Student){
        studentNames[currStu.name] = currStu
    }


/**
 Function to print the info for a student
 **/
func printInfoFor(personName:String)->String{
    if(!studentNames.keys.contains(personName)){
        return "Student does not exist in database"
    }
    print("Student in map")
    var currStudent = studentNames[personName]
    //    print(currStudent!.name)
    
    //Get and create the String of programming languages for the student from the array
    var languageString: String = ""
    var count: Int = 0
    while (count < currStudent!.programmingLanguages.count){
        languageString += currStudent!.programmingLanguages[count]
        count+=1
        if(count == (currStudent!.programmingLanguages.count - 1)){
            languageString += ", and "
        }
        else if (count != currStudent!.programmingLanguages.count){
            languageString += ", "
        }
    }
    
    //Create the String of hobbies for the student from the array
    var hobbyString: String = ""
    
    count = 0
    repeat{
        hobbyString += currStudent!.hobbies[count]
        count+=1
        if(count == (currStudent!.hobbies.count - 1)){
            hobbyString += ", or "
        }
        else if (count != currStudent!.hobbies.count){
            hobbyString += ", "
        }
    }while (count < currStudent!.hobbies.count)
    
    //Create the String of goals for the student from the array
    var goalString:String = ""
    
    for index in (0...currStudent!.futureGoals.count-1){
        goalString += currStudent!.futureGoals[index]
        if(index == (currStudent!.futureGoals.count - 2)){
            goalString += ", and "
        }
        else if (index != currStudent!.futureGoals.count-1){
            goalString += ", "
        }
        
    }
    
    var genderDeclarationUpper:String!
    var genderDeclarationLower:String!
    
    if(currStudent!.gender == "M"){
        genderDeclarationUpper = "He"
        genderDeclarationLower = "he"
    }
    
    if (currStudent!.gender == "F"){
        genderDeclarationUpper = "She"
        genderDeclarationLower = "she"
    }
    
    
    var info: String = (currStudent!.name + " (" + String(currStudent!.gender) + ") is from ")
    info += currStudent!.hometown
    info += (" and " + genderDeclarationLower + " is studying " + currStudent!.degree + ". ")
    info += (genderDeclarationUpper + " has " + String(currStudent!.familyMembers) + " siblings. ")
    info += (genderDeclarationUpper + " knows how to program in " + languageString + ". ")
    info += ("Aside from being an engineer, " + currStudent!.name + " also enjoys " + hobbyString + ". ")
    info += ("In the future, " + genderDeclarationLower + " hopes to be able to work for " + goalString + ". ")
    
    
    
   return info
    
}
    //function to return the map of students
    func studentMap()->[String:Student]{
        return studentNames
    }
}