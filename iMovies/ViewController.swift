//
//  ViewController.swift
//  iMovies
//
//  Created by Guilherme Muniz Viana on 18/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
         loadMovies()
    }
    
    func loadMovies() {
        guard let fileUrl = Bundle.main.url(forResource: "movies", withExtension: "json") else { return }
        
        do {
            
            // Varíavel para capturar os dados do JSON
            let data = try Data(contentsOf: fileUrl)
            
            // Decoficando o JSON em um Array de movie
            movies = try JSONDecoder().decode([Movie].self, from: data)
            
            
            for movie in movies {
                print("\(movie.title) - \(movie.rating)")
            }
        } catch {
            print(error.localizedDescription)
        }
    
    }
 

}

