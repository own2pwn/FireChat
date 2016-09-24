//
//  ViewController.swift
//  FireChat
//
//  Created by Daniel J Janiak on 9/23/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!    
    @IBOutlet var textField: UITextField!
    
    // MARK: - Properties
    
    let cellIdentifier = "TableViewCell"
    var messages: [FIRDataSnapshot]! = [FIRDataSnapshot]()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        textField.delegate = self
        
        /* Add an observer to fire whenever the keyboard is shown or hidden */
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow"), name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: self.view.window)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // For debugging: Force logout
//        let firebaseAuth = FIRAuth.auth()
//        
//        do {
//            try firebaseAuth?.signOut()
//        } catch let signOutError as NSError {
//            print(" *** Failed to sign out *** ")
//        }
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("firebaseLoginViewController")
            
            self.navigationController?.presentViewController(loginVC!, animated: true, completion: nil)
            
        }
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        
        let message = messageSnapshot.value as! [String: String]
        
        let text = message["text"] as String!
        
        cell.textLabel?.text = text
        
        return cell
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("The text field should return")
        
        self.view.endEditing(true)
        
        return true
    }
    
}

extension ViewController {
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject: AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue().size
        
        if keyboardSize.height == offset.height {
            
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.2) {
                    
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        } else {
            
            UIView.animateWithDuration(0.2) {
                
                self.view.frame.origin.y += keyboardSize.height - offset.height
                
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        
        /* Return the view to where it should be */
        
        let userInfo: [NSObject: AnyObject] = (sender as NSNotification).userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue().size
        
        self.view.frame.origin.y += keyboardSize.height
    }
}