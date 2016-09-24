//
//  Utilities.swift
//  FireChat
//
//  Created by Daniel J Janiak on 9/23/16.
//  Copyright © 2016 Daniel J Janiak. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    func showAlert(title: String, message: String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
        
        viewController.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func getDate() -> String {
        
        let today: NSDate = NSDate()
        
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return dateFormatter.stringFromDate(today)
    }
    
}