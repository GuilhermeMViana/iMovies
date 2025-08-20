//
//  UIViewController+CoreData.swift
//  iMovies
//
//  Created by Guilherme Muniz Viana on 20/08/25.
//

import UIKit
import CoreData

extension UIViewController {
    
    // Var to access object context from anywhere
    var context: NSManagedObjectContext {
        
        // Refers to AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // Is possible to access context from .viewContext in persistentContainer.
        // Returning the context
        return appDelegate.persistentContainer.viewContext
    }
}
