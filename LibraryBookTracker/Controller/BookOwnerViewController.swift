//
//  BookOwnerViewController.swift
//  LibraryBookTracker
//
//  Created by Brian Surgenor on 30/01/2020.
//  Copyright © 2020 Brian Surgenor. All rights reserved.
//

import UIKit

class BookOwnerViewController: UITableViewController {
    
    var service = ClassroomService()
    var selectedClass: Class?
    var bookOwners = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        bookOwners = service.loadBooks(className: selectedClass!.name!)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookOwners.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerCell", for: indexPath)
        let book = bookOwners[indexPath.row]
        let text = "\(book.owner!) - \(book.title!)"
        cell.textLabel?.text = text
        cell.accessoryType = book.paid ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookOwners[indexPath.row].paid = !bookOwners[indexPath.row].paid
        service.saveBook()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }

    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "GoToCamera", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CameraViewController
        destination.currentClass = selectedClass
    }
    
    func loadData() {
        bookOwners = service.loadBooks(className: selectedClass!.name!)
        tableView.reloadData()
    }
}
