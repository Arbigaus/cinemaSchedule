//
//  SessionViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 30/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    var moviesList = [ Movies ]()
    var session : Sessions? = nil
    var cinema  : Cinema? = nil
    var sessionToSave : sessionsStruct? = nil
    let cinemaModel = CinemaModelView()
    
    let rooms = ["Sala 1", "Sala 2", "Sala 3", "Sala 4", "Sala 5" ]
    
    var selectedRoom  : String = "Sala 1"
    var selectedMovie : Movies? = nil
    var selectedDate  : Date? = nil

    @IBOutlet weak var moviePicker: UIPickerView!
    @IBOutlet weak var roomPickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var cineImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (self.session != nil) ? "Editar Sessão" : "Inserir Sessão"
        
        self.cinemaName.text = cinema?.name
        
        self.moviePicker.delegate = self
        self.roomPickerView.delegate = self
        
        self.selectedDate = self.datePickerView.date
        
        // Cria a url usando o path
        let urlImage = URL(string: (self.cinema?.image)!)
        
        // faz download dos bytes da img
        let bytes = try? Data(contentsOf: urlImage!)
        
        if bytes != nil {
            let image = UIImage(data: bytes!)
            self.cineImage.image = image
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let movies = MovieModelView()
        self.moviesList = movies.getMovies()
        
        if self.moviesList.count > 0 {
            self.selectedMovie = self.moviesList[0]
        }
        
        if self.session != nil {
            let indexOfRoom = self.rooms.lastIndex(of: (self.session?.room)!)
            self.roomPickerView.selectRow(indexOfRoom!, inComponent: 0, animated: true)
            
            let indexOfMovie = self.moviesList.lastIndex(of: (self.session?.movie)!)
            self.moviePicker.selectRow(indexOfMovie!, inComponent: 0, animated: true)
            
            self.datePickerView.date = (self.session?.date)!
            
        }
        
    }
    

    @IBAction func saveAction(_ sender: Any) {
        let sessionToSave = sessionsStruct(room: self.selectedRoom, date: self.selectedDate!, cine: self.cinema!, movie: self.selectedMovie!)
        
        if cinemaModel.createSession(session: sessionToSave) {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        self.selectedDate = self.datePickerView.date
    }
    
    
    
}


extension SessionViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == self.roomPickerView {
            return self.rooms.count
        } else if pickerView == self.moviePicker {
            return self.moviesList.count
        } else {
            return 0
        }       
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.roomPickerView {
            return self.rooms[row]
        } else if pickerView == self.moviePicker {
            return self.moviesList[row].title
        } else {
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.roomPickerView {
            self.selectedRoom = self.rooms[row]
        } else if pickerView == self.moviePicker {
            self.selectedMovie = self.moviesList[row]
        }
        
    }
    
    
}
