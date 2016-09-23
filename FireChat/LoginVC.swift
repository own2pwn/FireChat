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
                return
            }
            
            print("Successfully signed in! ")
            
            
            
            
        }
    }
    
    
    @IBAction func registerTapped(sender: AnyObject) {
    }
    

    @IBAction func forgotPasswordTapped(sender: AnyObject) {
    }
}
