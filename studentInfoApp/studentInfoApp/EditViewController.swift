//
//  EditViewController.swift
//  KevinChangHw3
//
//  Created by Kevin Chang on 9/16/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

class EditViewController:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //Mark: Properties
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var male: UILabel!
    @IBOutlet weak var female: UILabel!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var hometownField: UITextField!
    @IBOutlet weak var siblingCount: UITextField!

    @IBOutlet weak var careers: UITextField!
    @IBOutlet weak var hobbies: UITextField!
    @IBOutlet weak var programmingLanguages: UITextField!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var selectPhoto: UIButton!
    @IBOutlet weak var takePhoto: UIButton!
    let pickPhoto = UIImagePickerController()
    
    
    var newStudent:Student?
    var gender:Character! = "F"
    var initialImage:UIImage!
    
    func stateChanged(maleState:UISwitch){
        if genderSwitch.on{
            gender = "F"
           
        }
        else{
            gender = "M"
        }
    }
    //MARK:Delegates
    //Image was picked
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage]
        image.contentMode = .ScaleAspectFit
        image.image = chosenImage! as? UIImage
        initialImage = image.image
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    //User hit cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //func to take a photo
    
    @IBAction func takeThePhoto(sender: UIButton) {
        pickPhoto.allowsEditing = false
        pickPhoto.sourceType = UIImagePickerControllerSourceType.Camera
        pickPhoto.cameraCaptureMode = .Photo
        pickPhoto.modalPresentationStyle = .FullScreen
        presentViewController(pickPhoto, animated: true, completion: nil)
    }
    
    //func to select a photo
    @IBAction func selectThePhoto(sender: UIButton) {
        pickPhoto.allowsEditing = false
        pickPhoto.sourceType = .PhotoLibrary
        presentViewController(pickPhoto, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialImage = UIImage(named:"temp")!
        pickPhoto.delegate = self
        
        //set up the existing student information if it exists
        if let newStudent = newStudent{
            print("edit")
            navigationItem.title = newStudent.name
            firstName.text = newStudent.name.componentsSeparatedByString(" ")[0]
            lastName.text = newStudent.name.componentsSeparatedByString(" ")[1]
            major.text = newStudent.degree
            gender = newStudent.gender
            if(gender == "F"){
                genderSwitch.setOn(true, animated: true)
            }
            else if(gender == "M"){
                genderSwitch.setOn(false, animated: true)
            }
            hometownField.text = newStudent.hometown
            siblingCount.text = String(newStudent.familyMembers)
            
            let languageList = newStudent.programmingLanguages
            var languageString = String()
            for language in languageList{
                languageString += language
                if(language != languageList.last){
                    languageString += ", "
                }
            }
            programmingLanguages.text = languageString
            
            let hobbyList = newStudent.hobbies
            var hobbyString = String()
            for hobby in hobbyList{
                hobbyString += hobby
                if(hobby != hobbyList.last){
                    hobbyString += ", "
                }
            }
            hobbies.text = hobbyString
            
            let careerList = newStudent.futureGoals
            var careerString = String()
            for career in careerList{
                careerString += career
                if(career != careerList.last){
                    careerString += ", "
                }
            }
            careers.text = careerString
            
            initialImage = newStudent.photo
            image.image = newStudent.photo

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    

    
//     MARK: - Navigation
    

    @IBAction func cancelEdit(sender: UIBarButtonItem) {
       print("cancel")
        navigationController?.popViewControllerAnimated(true)
    }
    
    //Return true if items is supposed to be saved
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        //check if any fields are missing and highlight in red
        if(firstName.text!.isEmpty){
            firstName.backgroundColor = UIColor.redColor()
        }
        else{
            firstName.backgroundColor = UIColor.whiteColor()
        }
        if(lastName.text!.isEmpty){
            lastName.backgroundColor = UIColor.redColor()
        }
        else{
            lastName.backgroundColor = UIColor.whiteColor()
        }
        if(hometownField.text!.isEmpty){
            hometownField.backgroundColor = UIColor.redColor()
        }
        else{
            hometownField.backgroundColor = UIColor.whiteColor()
        }
        if(major.text!.isEmpty){
            major.backgroundColor = UIColor.redColor()
        }
        else{
            major.backgroundColor = UIColor.whiteColor()
        }
        if(hobbies.text!.isEmpty){
            hobbies.backgroundColor = UIColor.redColor()
        }
        else{
            hobbies.backgroundColor = UIColor.whiteColor()
        }
        if(programmingLanguages.text!.isEmpty){
            programmingLanguages.backgroundColor = UIColor.redColor()
        }
        else{
            programmingLanguages.backgroundColor = UIColor.whiteColor()
        }
        if(careers!.text!.isEmpty){
            careers.backgroundColor = UIColor.redColor()
        }
        else{
            careers.backgroundColor = UIColor.whiteColor()
        }
        if(siblingCount!.text!.isEmpty){
            siblingCount.backgroundColor = UIColor.redColor()
        }
        else{
            siblingCount.backgroundColor = UIColor.whiteColor()
        }
        
            
            //if all fields present, then perform task
        if(!(firstName.text!.isEmpty||lastName.text!.isEmpty||hometownField.text!.isEmpty||major.text!.isEmpty||hobbies.text!.isEmpty||programmingLanguages.text!.isEmpty||careers!.text!.isEmpty||siblingCount.text!.isEmpty)){
            return true
        }
        
       
        return false
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (saveButton === sender){
            print("save")
            
            var studentName = (firstName.text!)
            studentName = studentName + " "
            studentName = studentName + lastName.text!
            let studentHometown = hometownField.text!
            let studentDegree = major.text!
            let studentHobbies = hobbies.text!.componentsSeparatedByString(",+")
            let studentProgrammingLanguages = programmingLanguages.text!.componentsSeparatedByString(",+")
            let studentGoals = careers.text!.componentsSeparatedByString(",+")
//            print(siblingCount.text!)
            let studentFamilyMembers = Int(siblingCount.text!)!
            
            //Need to add the student so its initialized when trying to save
            newStudent = Student(name: studentName, hometown: studentHometown, degree: studentDegree, gender: gender, familyMembers:studentFamilyMembers, programmingLanguages:studentProgrammingLanguages,hobbies:studentHobbies, futureGoals:studentGoals, photo: initialImage)
            
            
        }
        
    
    }
 

}
