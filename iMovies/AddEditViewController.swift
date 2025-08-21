//
//  AddEditViewController.swift
//  iMovies
//
//  Created by Guilherme Muniz Viana on 20/08/25.
//

import UIKit

class AddEditViewController: UIViewController {
    
    var movie: Movie?

    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfCategories: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var ivMovie: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            ivMovie.image = movie.image as! UIImage?
            tfTitle.text = movie.title
            tfCategories.text = movie.categories
            tfRating.text = "⭐️ \(movie.rating)/10"
            tfDuration.text = movie.duration
            tvSummary.text = movie.summary
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Close keyboard on button click
        view.endEditing(true)
    }

    
    @IBAction func addEditMovie(_ sender: UIButton) {
        if (movie == nil) {
            // if nil then instances a new Movie Core Data
            movie = Movie(context: context)
        }
        
        movie?.title = tfTitle.text
        movie?.categories = tfCategories.text
        movie?.duration = tfDuration.text
        movie?.summary = tvSummary.text
        movie?.rating = Float(tfRating.text!) ?? 0
        movie?.image = ivMovie.image
        
        do {
            // Save any interaction made in context(add or edit a movie from db)
            try context.save()
            // Command to return to last screen
            navigationController?.popViewController(animated: true)
        } catch {print(error.localizedDescription)}
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
