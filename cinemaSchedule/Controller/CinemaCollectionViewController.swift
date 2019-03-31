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
    
    var cinemaList = [ Cinema ]()
    var cinemaToSend : Cinema?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cinemas"

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cinemas = CinemaModelView()
        self.cinemaList = cinemas.getCinemas()
        
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.cinemaList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cinemaCell", for: indexPath) as! CinemaCollectionViewCell
        
        // Cria a url usando o path
        let urlImage = URL(string: self.cinemaList[indexPath.row].image!)
        
        // faz download dos bytes da img
        let bytes = try? Data(contentsOf: urlImage!)
        var image : UIImage? = nil
        if bytes != nil {
            image = UIImage(data: bytes!)
            cell.cinemaImage.image = image
        }
        
        cell.cinemaName.text = self.cinemaList[indexPath.row].name!
        return cell
    }

    // MARK: Segue definitions
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cinemaToSend = cinemaList[indexPath.row]
        
        performSegue(withIdentifier: "goToCinemaViewFromMovies", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==
            "goToCinemaViewFromMovies" {
            let vc : CinemaViewController = segue.destination as! CinemaViewController
            vc.cinema = cinemaToSend
        }
    }

}
