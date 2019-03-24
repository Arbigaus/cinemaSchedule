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

    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var cinemaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        cinemaCollectionView.delegate = self
        
        movieCollectionView.dataSource = self
        cinemaCollectionView.dataSource = self
        
//        self.view.addSubview(movieCollectionView)
//        self.view.addSubview(cinemaCollectionView)
        
    }

}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.movieCollectionView {
            return 10
        } else if collectionView == self.cinemaCollectionView {
            return 5
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.movieCollectionView {
            let movieCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
            movieCell?.movieTitle.text = "Movie \(indexPath.row)"
            return movieCell!
        } else {
            let cinemaCell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: "cinemaCell", for: indexPath) as? CinemaCollectionViewCell
            cinemaCell?.titleCinema.text = "Cine \(indexPath.row)"
            return cinemaCell!
        }
        
    }
    
    
}
