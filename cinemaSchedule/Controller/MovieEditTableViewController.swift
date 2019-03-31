//
//  MovieEditTableViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 29/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

class MovieEditTableViewController: UITableViewController {
    var moviesList = [ Movies ]()
    var movieToSend : Movies?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filmes"
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let buttonAdd = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(self.addItem))
        self.navigationItem.rightBarButtonItems = [buttonAdd]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Instance the movie model view to get list of movies
        let movies = MovieModelView()
        self.moviesList = movies.getMovies()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.moviesList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieEditList", for: indexPath)

        cell.textLabel?.text = self.moviesList[indexPath.row].title

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieToSend = self.moviesList[indexPath.row]
        
        performSegue(withIdentifier: "insertMovie", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "insertMovie"{
            let vc : EditMovieViewController = segue.destination as! EditMovieViewController
            vc.movie = self.movieToSend
        }
        
    }
    
    @objc func addItem(){
        self.movieToSend = nil
        performSegue(withIdentifier: "insertMovie", sender: self)
    }

}