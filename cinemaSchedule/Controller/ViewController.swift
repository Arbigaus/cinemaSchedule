//
//  ViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 15/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var index : Int? = nil
    var moviesList = [ Movies ]()
    var movieToSend : Movies?

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var cinemaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let movies = MovieModelView()
        self.moviesList = movies.getMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
        
        movieCollectionView.delegate = self
        cinemaCollectionView.delegate = self
        
        movieCollectionView.dataSource = self
        cinemaCollectionView.dataSource = self
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.movieCollectionView {
            return self.moviesList.count
        } else if collectionView == self.cinemaCollectionView {
            return 5
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.movieCollectionView {
            let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? FirstMovieCollectionViewCell
            
            movieCell?.movieImage.image = UIImage(named: moviesList[indexPath.row].image!)
            
            return movieCell!
        } else {
            let cinemaCell = cinemaCollectionView.dequeueReusableCell(withReuseIdentifier: "cinemaCell", for: indexPath) as? FirstCinemaCollectionViewCell
            
            cinemaCell?.titleCinema.text = "Cine \(indexPath.row + 1)"
            
            return cinemaCell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.movieToSend = moviesList[indexPath.row]
        
        if collectionView == self.movieCollectionView {
            performSegue(withIdentifier: "goToMovieView", sender: self)
        }
        
        if collectionView == self.cinemaCollectionView {
            performSegue(withIdentifier: "goToCinemaView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieView" {
            let vc : MovieViewController = segue.destination as! MovieViewController
            vc.movie = self.movieToSend
        } else if segue.identifier == "goToCinemaView"{
            let vc : CinemaViewController = segue.destination as! CinemaViewController
            
        }
    }
}
