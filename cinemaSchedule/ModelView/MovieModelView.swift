//
//  MovieModelView.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 25/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit
import CoreData

class MovieModelView  {
    private var MoviesList : [Movies] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        let get : NSFetchRequest<Movies> = Movies.fetchRequest()
        
        do {
            MoviesList = try context.fetch(get)
        } catch {
            print("Erro: \(error)")
        }
        
        /*
        let insertMovie = MovieStruct(title : "O Senhor dos Anéis: As Duas Torres", director : "Peter Jackson", time : 142,
                                      image : "lotr2.jpg", year : 2001, type : "Fantasia", age: 16)
        
        if createMovie(movie: insertMovie) {
            print("Criado o filme \(insertMovie.title)")
        }
        
        
        let insertMovie2 = MovieStruct(title : "Avengers | Age of Ultron", director : "Joss Whedon", time : 228,
                                       image : "OsVingadores2.jpg", year : 2015, type : "Aventura", age: 16)
        
        if createMovie(movie: insertMovie2) {
            print("Criado o filme \(insertMovie2.title)")
        }
        
        let insertMovie3 = MovieStruct(title : "Harry Potter e a Pedra Filosofal", director : "Chris Columbus", time : 149,
                                       image : "hp1.jpg", year : 2015, type : "Aventura", age: 1)
        
        if createMovie(movie: insertMovie3) {
            print("Criado o filme \(insertMovie3.title)")
        }
        */
        
    }
    
    public func getMovies() -> [Movies] {
        return MoviesList
    }
    
    public func createMovie(movie: MovieStruct) -> Bool {
        let cMovie = Movies(context: self.context)
        
        cMovie.title    = movie.title
        cMovie.time     = Int16(movie.time)
        cMovie.director = movie.director
        cMovie.image    = movie.image
        cMovie.year     = Int16(movie.year)
        cMovie.type     = movie.type
        cMovie.age      = Int16(movie.age)
        
        do {
            try context.save()
            return true
        } catch {
            print("Erro: \(error)")
            return false
        }
        
    }
    
}

struct MovieStruct {
    var title    : String
    var director : String
    var time     : Int
    var image    : String
    var year     : Int
    var type     : String
    var age      : Int
    
}
