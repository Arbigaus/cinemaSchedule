//
//  CinemaViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 23/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit
import MapKit

class CinemaViewController: UIViewController {
    var cinema : Cinema?
    var sessionToSend : Sessions? = nil
    var sessions = [ Sessions ]()
    
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()

    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var cinemaAddress: UILabel!
    @IBOutlet weak var cinemaMap: MKMapView!
    @IBOutlet weak var cinemaCep: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let startLocation = CLLocation(latitude: -25.451389, longitude: -49.251667)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cinema?.name
        
        var cep = String(cinema!.address!.cep)
        let cineAddress = "\(cinema!.address!.street!), \(cinema!.address!.number)"
        
        cep.insert("-", at: cep.index(cep.endIndex, offsetBy: -3) )
        
        cinemaName.text = cinema?.name
        cinemaAddress.text = cineAddress
        cinemaCep.text = "CEP: \(cep)"
        
        // Register the tableView
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sessionCinemaList")
        
        // Inserir botão para criar sessão
        let buttonAdd = UIBarButtonItem(title: "Adic. Sessão", style: .plain, target: self, action: #selector(self.addItem))
        self.navigationItem.rightBarButtonItems = [buttonAdd]
        
        // Pegar sessions
        self.sessions = (self.cinema?.sessions?.toArray())!
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.sessionToSend = nil
        let cineAddress = "\(cinema!.address!.city!), \(cinema!.address!.street!), \(cinema!.address!.number)"
        self.setMap(address: cineAddress)
        
        self.tableView.reloadData()
        self.sessionToSend = nil
        
    }
    
    private func setMap(address: String){
        CinemaViewController.geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            if error != nil {
                print("Erro")
            } else if let placemarks = placemarks {
                
                if let coordinate = placemarks.first?.location?.coordinate {
                    self.cinemaMap.mapType = .standard
                    let span   = MKCoordinateSpan(latitudeDelta: 0.0175, longitudeDelta: 0.0175)  // trazer nome da cidade
                    let region = MKCoordinateRegion(center: coordinate, span: span)  // define onde e o span para mostrar a regiao
                    
                    self.cinemaMap.setRegion(region, animated: true)
                    
                    let anotacao = MKPointAnnotation()
                    anotacao.coordinate = coordinate
                    anotacao.title = self.cinema?.name
                    self.cinemaMap.addAnnotation(anotacao)
                    
                }
            }
        }
    }

    
    // MARK: - Navigation

     @objc func addItem(){
        performSegue(withIdentifier: "goSessionFromCinema", sender: self)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==
            "goSessionFromCinema" {
            let vc : SessionViewController = segue.destination as! SessionViewController
            vc.cinema = self.cinema
            vc.session = self.sessionToSend
            
        }
    }

}

extension CinemaViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.sessions.count)
//        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sessionCinemaList", for: indexPath) as UITableViewCell
        let movie = (self.sessions[indexPath.row].movie?.title!)!
        let room  = self.sessions[indexPath.row].room!
        let date  = self.sessions[indexPath.row].date!
        
        
        cell.textLabel?.text = "\(movie) | \(room) - \(date.toString(dateFormat: "dd/MM/yyyy - HH:mm"))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.sessionToSend = sessions[indexPath.row]
        performSegue(withIdentifier: "goSessionFromCinema", sender: self)
    }
    
    
}

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
