//
//  CinemaCollectionViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 24/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CinemaCollectionViewController: UICollectionViewController {
    var index : Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cinemas"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cinemaCell", for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: Segue definitions
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row + 1
        
        performSegue(withIdentifier: "goToCinemaViewFromMovies", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==
            "goToCinemaViewFromMovies" {
            let vc : CinemaViewController = segue.destination as! CinemaViewController
            vc.n = "Cinema \(self.index!)"
            vc.address = "Rua dos Burros, n. \(self.index!)"
        }
    }

}
