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
    var t : String    = ""
    var time : Int = 0
    var age : Int  = 0
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieAge: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = t
        
        movieTitle.text = movie?.title
        movieTime.text  = String(movie!.time)
        movieAge.text   = String(16)
        movieImage.image = UIImage(named: movie!.image!)
        
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
