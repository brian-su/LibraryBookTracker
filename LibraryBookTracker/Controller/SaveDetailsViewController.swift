//
//  SaveDetailsViewController.swift
//  LibraryBookTracker
//
//  Created by Brian Surgenor on 02/02/2020.
//  Copyright © 2020 Brian Surgenor. All rights reserved.
//

import UIKit

class SaveDetailsViewController: UIViewController {
    
    var book: BookModel?
    var currentClass: Class?
    var service = ClassroomService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = book?.title
        subTitleLabel.text = book?.subtitle
        authorLabel.text = book?.author
        nameTextField.placeholder = "Enter Student Name Here"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Enter a name!", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let newBook = Book(context: context)
        newBook.parent = currentClass
        newBook.authors = book?.author
        newBook.title = book?.title
        newBook.subtitle = book?.subtitle
        newBook.owner = nameTextField.text!
        
        service.saveBook()
        
        performSegue(withIdentifier: "OnSaveBook", sender: self)
    }
    
}
