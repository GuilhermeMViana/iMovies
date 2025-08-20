//
//  MoviesTableViewController.swift
//  iMovies
//
//  Created by Guilherme Muniz Viana on 19/08/25.
//

import UIKit
import CoreData

class MoviesTableViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Movie>!
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadMovies() {
        // read core data objects. fetch from Moview because we need all movies
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        // Sort movies by alphabetical order
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        /*
         instantiating fetchedResultsController. needs fetchRequest and context(extension created in UIViewController+CoreData)
        */
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        /*
         Claims this class as delegate from fetchedResultsController. It will be responsible to be called when something happens with the movies context.
         */
        fetchedResultsController.delegate = self
        do {
            // Requisiting movies
            try fetchedResultsController.performFetch()
        } catch {
            print("Erro ao carregar filmes: \(error)")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // return count of objects in fetchedResultsController
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = fetchedResultsController.object(at: indexPath)
        
        cell.lbTitle?.text = movie.title
        cell.lbSummary?.text = movie.summary
        cell.ivMovie.image = movie.image as? UIImage

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? ViewController {
            
            // IndexPath used to get index of movies
            let movie = fetchedResultsController.object(at: tableView.indexPathForSelectedRow!)
            
            // Sending movie to next screen
            vc.movie = movie
        }
    }

}

extension MoviesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
