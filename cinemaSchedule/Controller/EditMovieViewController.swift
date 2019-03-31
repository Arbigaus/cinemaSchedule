//
//  EditMovieViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 29/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

class EditMovieViewController: UIViewController {
    var movie : Movies? = nil

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (movie?.title != nil) ? "Editar Filme" : "Inserir Filme"

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        movie = nil
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
