//
//  BookDetailsService.swift
//  LibraryBookTracker
//
//  Created by Brian Surgenor on 30/01/2020.
//  Copyright © 2020 Brian Surgenor. All rights reserved.
//

import Foundation

protocol BookDetailsDelegate {
    func didFindData(_ book: BookModel)
}

struct BookDetailsService {
    
    var delegate: BookDetailsDelegate?
    
    func getDetails(isbn: String) {
        let url = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyBSNEgNTFKShj46C5RaxiobxhM81Uwhif8"
        
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if(error != nil) {
                    print(error)
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let parsed = try decoder.decode(BookDetails.self, from: safeData).items[0]
                        let book = BookModel(title: parsed.volumeInfo.title, subtitle: parsed.volumeInfo.subtitle, author: parsed.volumeInfo.authors.joined())
                        self.delegate?.didFindData(book)
                    } catch {
                        print("Error \(error)")
                    }
                }
            }
            task.resume()
        }
    }
}
