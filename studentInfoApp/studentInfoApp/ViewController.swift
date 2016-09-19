//
//  ViewController.swift
//  KevinChangHw3
//
//  Created by Kevin Chang on 9/14/16.
//  Copyright © 2016 Kevin Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Mark: Properties
    @IBOutlet weak var DukeLogo: UIImageView!
    @IBOutlet weak var errorText: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        errorText.hidden = true
        super.viewDidLoad()
//        loginButton.addTarget(self, action: #selector(self.buttonTapped), forControlEvents: .TouchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    //if wrong login, don't perform segue
     override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(loginTextField.text!.containsString("@duke.edu")){
            errorText.hidden = true
            return true
        }
        else {
            errorText.hidden = false
            return false
        }
        

        
    }
    func buttonTapped(sender:UIButton){
        errorText.bringSubviewToFront(errorText)
    }


}

