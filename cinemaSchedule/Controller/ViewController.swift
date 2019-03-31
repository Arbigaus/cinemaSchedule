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
    
    var cinemaList = [ Cinema ]()
    var cinemaToSend : Cinema?

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var cinemaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
        
        movieCollectionView.delegate = self
        cinemaCollectionView.delegate = self
        
        movieCollectionView.dataSource = self
        cinemaCollectionView.dataSource = self
        
        let movies  = MovieModelView()
        let cinemas = CinemaModelView()
        self.moviesList = movies.getMovies()        
        self.cinemaList = cinemas.getCinemas()
        
        if self.moviesList.count < 1 {
            movies.insertFirstMovies()
            self.moviesList = movies.getMovies()
        }
        
        if self.cinemaList.count < 1 {
            cinemas.createFirstCinemas()
            self.cinemaList = cinemas.getCinemas()
        }
        
        self.cinemaCollectionView.reloadData()
        self.movieCollectionView.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.movieCollectionView {
            return self.moviesList.count
        } else if collectionView == self.cinemaCollectionView {
            return self.cinemaList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.movieCollectionView {
            let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? FirstMovieCollectionViewCell
            
            // Cria a url usando o path
            let urlImage = URL(string: self.moviesList[indexPath.row].image!)
            
            // faz download dos bytes da img
            let bytes = try? Data(contentsOf: urlImage!)
            var image : UIImage? = nil
            if bytes != nil {
                image = UIImage(data: bytes!)
                movieCell?.movieImage.image = image
            }
            
            
            return movieCell!
        } else {
            let cinemaCell = cinemaCollectionView.dequeueReusableCell(withReuseIdentifier: "cinemaCell", for: indexPath) as? FirstCinemaCollectionViewCell
            
            cinemaCell?.titleCinema.text = cinemaList[indexPath.row].name
            
            // Cria a url usando o path
            let urlImage = URL(string: self.cinemaList[indexPath.row].image!)
            
            // faz download dos bytes da img
            let bytes = try? Data(contentsOf: urlImage!)
            var image : UIImage? = nil
            if bytes != nil {
                image = UIImage(data: bytes!)
                cinemaCell?.cinemaImage.image = image
            }
            
            return cinemaCell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.movieCollectionView {
            self.movieToSend = moviesList[indexPath.row]
            performSegue(withIdentifier: "goToMovieView", sender: self)
        }
        
        if collectionView == self.cinemaCollectionView {
            self.cinemaToSend = cinemaList[indexPath.row]
            performSegue(withIdentifier: "goToCinemaView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieView" {
            let vc : MovieViewController = segue.destination as! MovieViewController
            vc.movie = self.movieToSend
        } else if segue.identifier == "goToCinemaView"{
            let vc : CinemaViewController = segue.destination as! CinemaViewController
            vc.cinema = self.cinemaToSend
            
        }
    }
}
