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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movies = Movies(context: context)
        
        movies.id       = UUID()
        movies.name     = "LOTR - Lord of The Rings"
        movies.director = "Peter Jackson"
        movies.year     = 2001
        movies.type     = "Fantasy"
        
        do {
            try context.save()
        } catch {
            print("Ocorreu algum erro: \(error)")
        }
        
        var listMovies : [Movies] = []
        let requisition : NSFetchRequest<Movies> = Movies.fetchRequest()
        
        do {
            listMovies = try context.fetch(requisition)
            
        } catch {
            print("Ocorreu algum erro ao buscar: \(error)")
        }
        
        print(listMovies)
        
        
    }


}

