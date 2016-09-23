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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // For debugging: Force logout
        let firebaseAuth = FIRAuth.auth()
        
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print(" *** Failed to sign out *** ")
        }
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("firebaseLoginViewController")
            
            self.navigationController?.presentViewController(loginVC!, animated: true, completion: nil)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

