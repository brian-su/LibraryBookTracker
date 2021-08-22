//
//  ClassroomService.swift
//  LibraryBookTracker
//
//  Created by Brian Surgenor on 30/01/2020.
//  Copyright © 2020 Brian Surgenor. All rights reserved.
//

import UIKit
import CoreData

struct ClassroomService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveClass(classroom: String) -> Class? {
        let newClass = Class(context: self.context)
        newClass.name = classroom

        do {
            try context.save()
            return newClass
        } catch {
            print("Error saving the class \(error)")
            return nil
        }
    }
    
    func saveBook() {
        do {
            try context.save()
        } catch {
            print("Error saving the class \(error)")
        }
    }
    
    func loadClasses() -> [Class] {
        let request: NSFetchRequest<Class> = Class.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error: \(error)")
            return [Class]()
        }
    }
    
    func loadBooks(className: String) -> [Book] {
        let predicate = NSPredicate(format: "parent.name MATCHES %@", className)
        let request: NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error: \(error)")
            return [Book]()
        }
    }
}
