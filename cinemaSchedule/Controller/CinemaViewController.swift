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
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()

    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var cinemaAddress: UILabel!
    @IBOutlet weak var cinemaMap: MKMapView!
    @IBOutlet weak var cinemaCep: UILabel!
    
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cineAddress = "\(cinema!.address!.street!), \(cinema!.address!.number)"
        self.setMap(address: cineAddress)
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
                    
                    self.cinemaMap.setRegion(region, animated: false)
                    
                    let anotacao = MKPointAnnotation()
                    anotacao.coordinate = coordinate
                    anotacao.title = self.cinema?.name
                    self.cinemaMap.addAnnotation(anotacao)
                    
                }
            }
        }
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
