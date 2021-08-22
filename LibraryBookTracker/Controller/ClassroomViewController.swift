//
//  ViewController.swift
//  LibraryBookTracker
//
//  Created by Brian Surgenor on 30/01/2020.
//  Copyright © 2020 Brian Surgenor. All rights reserved.
//

import UIKit
import CoreData

class ClassroomViewController: UITableViewController {
    
    var classArray = [Class]()
    let classroomService = ClassroomService()

    override func viewDidLoad() {
        super.viewDidLoad()
        classArray = classroomService.loadClasses()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassroomCell", for: indexPath)
        cell.textLabel?.text = classArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToClass", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! BookOwnerViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedClass = classArray[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a New Class", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        
        var textField = UITextField()
        alert.addTextField { (alertText) in
            alertText.placeholder = "Please enter a class name"
            textField = alertText
        }
        
        let action = UIAlertAction(title: "Add Class", style: .default) { (action) in
            if let newClass = self.classroomService.saveClass(classroom: textField.text!) {
                self.classArray.append(newClass)
                self.tableView.reloadData()
            } else {
                //Something went wrong implement error handling?
            }
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
}

