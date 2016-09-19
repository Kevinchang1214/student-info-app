//
//  StudentTableViewController.swift
//  KevinChangHw3
//
//  Created by Kevin Chang on 9/16/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    @IBOutlet weak var teamLabel: UILabel!
    
    // Mark:Properties
    var studentInfos = AllStudents()
    var studentCollection = [String:Student]()
    var studentPhotos = [UIImage]()
    var keyArr:[String] = [String]()
    var first = true
    
    
    
    //Function loads the information for my teammates
    func getStudents()-> [String:Student]{
        return studentCollection
    }
    
    func addMyTeam(){
        let myPhoto = UIImage(named:"myProfilePhoto")!
        studentInfos.addStudent("Kevin Chang", studentHometown: "San Jose, Ca", studentDegree: "ECE/CS", studentGender: "M", studentFamilyMembers: 0, studentProgrammingLanguages: ["Java", "Swift", "C", "Python"], studentHobbies: ["Water Polo", "Mixing music"], studentGoals: ["Google", "Facebook", "Microsoft"],studentPhoto: myPhoto)
        
        let tommysPhoto = UIImage(named:"tommysPhoto")!
        studentInfos.addStudent("Tommy Romano", studentHometown: "Fairfield, Ct", studentDegree: "ECE/CS", studentGender: "M", studentFamilyMembers: 2, studentProgrammingLanguages: ["java", "C", "python", "php"], studentHobbies: ["long walks on the beach", "eating eggs"], studentGoals: ["Facebook", "pitchoforks", "himself"],studentPhoto: tommysPhoto)
        
        let elsiesPhoto = UIImage(named:"elsiesPhoto")!
        studentInfos.addStudent("Elsie Ling", studentHometown: "Shanghai, China", studentDegree: "ECE/CS", studentGender: "F", studentFamilyMembers: 2, studentProgrammingLanguages: ["Java","C","Python"], studentHobbies: ["travelling", "singing"], studentGoals: ["Microsoft"],studentPhoto: elsiesPhoto)
        
        let dansPhoto = UIImage(named:"dansPhoto")!
        studentInfos.addStudent("Dan Li", studentHometown: "Cary, NC", studentDegree: "ECE", studentGender: "M", studentFamilyMembers: 1, studentProgrammingLanguages: ["Java","Clojure","Python","Javascript"], studentHobbies: ["cooking", "hiking"], studentGoals: ["Airtable","Cruise Automation"],studentPhoto: dansPhoto)
        
        studentPhotos = [myPhoto, tommysPhoto,elsiesPhoto, dansPhoto]
        studentCollection = studentInfos.studentMap()
        for key in studentCollection.keys{
            keyArr.append(key)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the team data
        navigationItem.leftBarButtonItem = editButtonItem()
        
        addMyTeam()
        first = false
        
        if let savedStudents = loadStudents(){
            print("load")
            studentInfos = savedStudents
            for key in studentInfos.studentMap().keys{
                print (key)
                if(studentCollection[key]==nil){
                    studentCollection[key] = studentInfos.studentMap()[key]
                    keyArr.append(key)
                }
            }
            
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentCollection.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var myTeamIdentifier:String = String()
        
        if(indexPath.row == 0||indexPath.row == 1||indexPath.row == 2||indexPath.row == 3){
            myTeamIdentifier = "StudentTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(myTeamIdentifier, forIndexPath: indexPath) as! StudentTableViewCell
            
            //Grab the specific student
            
            let currKey = keyArr[indexPath.row]
            let currStudent = studentCollection[currKey]
            
            // Configure the cell...
            
            cell.myNameField.text = currStudent!.name
            cell.myMajor.text = currStudent!.degree
            cell.myMajor.editable = false
            cell.myProfilePhoto.image! = currStudent!.photo
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.myNameField.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 17)
            cell.myMajor.font = UIFont(name: "AppleSDGothicNeo-Thin",size:20)
            
            return cell
        }
        else{
            myTeamIdentifier = "MemberTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(myTeamIdentifier, forIndexPath: indexPath) as! MemberTableViewCell
            
            //Grab the specific student
            
            let currKey = keyArr[indexPath.row]
            let currStudent = studentCollection[currKey]
            
            // Configure the cell...
            print(currKey)
            print(cell.memberName)
            
            cell.memberName.text = currStudent!.name
            cell.memberMajor.text = currStudent!.degree
            cell.memberMajor.editable = false
            cell.memberPhoto.image! = currStudent!.photo
            cell.memberHometown.text = currStudent!.hometown
            return cell
        }
    }
    
    //dismiss keyboard when touch outside
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    @IBAction func unwindToStudentList(sender:UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as?
            EditViewController, newStudent = sourceViewController.newStudent{
            
            //if we are editing and the name is the same
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                studentCollection[keyArr[selectedIndexPath.row]] = newStudent
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
                // Store the newly created student into the data structures
            else{
                
                let newIndex = NSIndexPath(forRow:studentCollection.count,inSection:0)
                //                print (newStudent.name)
                studentCollection[newStudent.name] = newStudent
                keyArr.append(newStudent.name)
                tableView.insertRowsAtIndexPaths([newIndex], withRowAnimation:.Bottom )
                
            }
            //don't save if we are adding team member
            if(keyArr.indexOf(newStudent.name)>3){
                studentInfos.newStudent = newStudent
                print("saved")
                saveStudents()
            }
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.row<=3){
            return false;
        }
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            deleteStudent(studentCollection[keyArr[indexPath.row]]!)
            studentCollection.removeValueForKey(keyArr[indexPath.row])
            keyArr.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let studentDetailViewController = segue.destinationViewController as! EditViewController
            
            if let selectedStudent = sender as? StudentTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedStudent)!
                let student = studentCollection[keyArr[indexPath.row]]
                studentDetailViewController.newStudent = student
            }
        }
        if segue.identifier == "memberDetail"{
            let studentDetailViewController = segue.destinationViewController as! EditViewController
            if let selectedStudent = sender as? MemberTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedStudent)!
                let student = studentCollection[keyArr[indexPath.row]]
                studentDetailViewController.newStudent = student
            }
            
        }
        else if segue.identifier == "addItem" {
            print("adding new student")
        }
        
    }
    
    //Mark: NSCoding, adapted from apple developer tutorials
    func saveStudents(){
        let saved = NSKeyedArchiver.archiveRootObject(studentInfos, toFile: AllStudents.ArchiveURL.path!)
        
        if(!saved){
            print ("Failed to save")
        }
    }
    
    func loadStudents() -> AllStudents?{
        //        print(NSKeyedUnarchiver.unarchiveObjectWithFile(AllStudents.ArchiveURL.path!) as? AllStudents)
        print ("loaded")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(AllStudents.ArchiveURL.path!) as? AllStudents
        //        return nil
    }
    func deleteStudent(student:Student){
        let exists = NSFileManager.defaultManager().fileExistsAtPath(AllStudents.ArchiveURL.path!)
        if exists {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(AllStudents.ArchiveURL.path!)
            }catch let error as NSError {
                print("error: \(error.localizedDescription)")
                
            }
        }
    }
    
    
}
