//
//  LoginVC.swift
//  FireChat
//
//  Created by Daniel J Janiak on 9/23/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Helpers
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func blockGarbageIn() {
        
        // TODO: Check a text field string for obvious mistakes
    }
    
    // MARK: - Actions
    
    @IBAction func loginTapped(sender: AnyObject) {
        
        if emailTextField.text?.characters.count < 5 {
            
            // TODO: Present an alert
        }
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
            
            if let error = error {
                
                print("Awww .... there was an error: \(error.localizedDescription)")
                
                Utilities().showAlert("Error!", message: error.localizedDescription, viewController: self)
                
                return
            }
            
            print("Successfully signed in! ")
            
            Utilities().showAlert("Success!", message: "You have successfully logged in.  Way to go.", viewController: self)
            
            
        }
    }
    
    
    @IBAction func registerTapped(sender: AnyObject) {
        
        // TODO: Check the text field string for obvious mistakes
        
        let alert = UIAlertController(title: "Register", message: "Please confirm you password.", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler() { textfield in
            
            textfield.placeholder = "password"
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { action in
            
            /* Allow the user to register */
            
            let passwordConfirmation = alert.textFields![0] as UITextField
            
            if passwordConfirmation.text!.isEqual(self.passwordTextField.text!) {
                
                let email = self.emailTextField.text
                let password = self.passwordTextField.text
                
                FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { user, error in
                    
                    if let error = error {
                        Utilities().showAlert("Error", message: error.localizedDescription, viewController: self)
                        return
                    }
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }
                
            } else {
                Utilities().showAlert("Error", message: "The passwords do not match", viewController: self)
            }
            
        })
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    @IBAction func forgotPasswordTapped(sender: AnyObject) {
        
        guard emailTextField.text != nil else {
            return
        }
        
        if !emailTextField.text!.isEmpty {
            
            let email = self.emailTextField.text!
            
            FIRAuth.auth()?.sendPasswordResetWithEmail(email) { error in
                
                if let error = error {
                    Utilities().showAlert("Error", message: error.localizedDescription, viewController: self)
                    return
                }
                
                Utilities().showAlert("Got it", message: "Check your email for instructions on how to reset your password", viewController: self)
                
            }
        }
    }
}
