//
//  MovieViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 23/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    var movie : Movies?
    var sessions = [ Sessions ]()
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieAge: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        
        movieTitle.text  = movie?.title
        movieTime.text   = "\(String(movie!.time)) minutos"
        movieAge.text    = String(16)
        
        // Cria a url usando o path
        let urlImage = URL(string: movie!.image!)
        
        // faz download dos bytes da img
        let bytes = try? Data(contentsOf: urlImage!)
        var image : UIImage? = nil
        if bytes != nil {
            image = UIImage(data: bytes!)
            movieImage.image = image
        }
        
        // Register the tableView
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sessionMovieList")
        
        // Pegar a lista de sessões como array
        self.sessions = (self.movie?.sessions?.toArray())!
        
    }

}



extension MovieViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (movie?.sessions?.count)!
        return self.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sessionMovieList", for: indexPath) as UITableViewCell
        let cine = (self.sessions[indexPath.row].cinema?.name!)!
        let room = self.sessions[indexPath.row].room!
        let date = self.sessions[indexPath.row].date!
        
        cell.textLabel?.text = "\(cine) | \(room) - \(date)"
        
        return cell
    }
    
    
}

