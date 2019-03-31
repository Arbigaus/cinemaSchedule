//
//  MoviesCollectionViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 24/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController {
    var index : Int? = nil
    var moviesList = [ Movies ]()
    var movieToSend : Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filmes"
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Instance the movie model view to get list of movies
        let movies = MovieModelView()
        self.moviesList = movies.getMovies()
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.moviesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell1", for: indexPath) as? MovieCollectionViewCell
        
        // Cria a url usando o path
        let urlImage = URL(string: self.moviesList[indexPath.row].image!)
        
        // faz download dos bytes da img
        let bytes = try? Data(contentsOf: urlImage!)
        
        if bytes != nil {
            let image = UIImage(data: bytes!)
            cell?.movieImage.image = image
        }
        
        
        return cell!
    }
    
    // MARK: Segue definitions
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.movieToSend = self.moviesList[indexPath.row]
        
        performSegue(withIdentifier: "goToMovieViewFromMovies", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==
            "goToMovieViewFromMovies" {
            let vc : MovieViewController = segue.destination as! MovieViewController
            vc.movie = movieToSend
            
        }
    }

}
