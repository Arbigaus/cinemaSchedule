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
    var n : String = "Cinemas"
    var address : String = ""

    @IBOutlet weak var cinemaName: UILabel!
    @IBOutlet weak var cinemaAddress: UILabel!
    @IBOutlet weak var cinemaMap: MKMapView!
    
    let startLocation = CLLocation(latitude: -25.451389, longitude: -49.251667)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = n
        
        cinemaName.text = n
        cinemaAddress.text = address
        
        cinemaMap.mapType = .standard
        let span   = MKCoordinateSpan(latitudeDelta: 0.0275, longitudeDelta: 0.0275)  // trazer nome da cidade
        let region = MKCoordinateRegion(center: startLocation.coordinate, span: span)  // define onde e o span para mostrar a regiao
        
        cinemaMap.setRegion(region, animated: true)
        
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
