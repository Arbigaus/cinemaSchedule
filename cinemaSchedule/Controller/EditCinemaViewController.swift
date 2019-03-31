//
//  EditCinemaViewController.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 29/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit

class EditCinemaViewController: UIViewController {
    var cinema : Cinema? = nil
    
    @IBOutlet weak var cinemaNameTextField: UITextField!
    @IBOutlet weak var cinemaSiteTextField: UITextField!
    @IBOutlet weak var cineImgUrl: UITextField!
    @IBOutlet weak var cineAddressTextField: UITextField!
    @IBOutlet weak var cineAddrNumberTextField: UITextField!
    @IBOutlet weak var cineAddrZipCodeTextField: UITextField!
    @IBOutlet weak var cineAddrCityTextField: UITextField!
    @IBOutlet weak var cineAddrUfTextField: UITextField!
    
    
    @IBOutlet weak var cinemaLogoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (cinema?.name != nil) ? "Editar Cinema" : "Inserir Cinema"
 
        if cinema != nil {
            self.cinemaNameTextField.text      = cinema?.name
            self.cinemaSiteTextField.text      = cinema?.site
            self.cineImgUrl.text               = cinema?.image
            self.cineAddressTextField.text     = cinema?.address?.street
            self.cineAddrZipCodeTextField.text = String(cinema!.address!.cep)
            self.cineAddrNumberTextField.text  = String(cinema!.address!.number)
            self.cineAddrCityTextField.text    = cinema?.address?.city
            self.cineAddrUfTextField.text      = cinema?.address?.uf
            
            // Cria a url usando o path
            let urlImage = URL(string: self.cinema!.image!)
            
            // faz download dos bytes da img
            let bytes = try? Data(contentsOf: urlImage!)
            var image : UIImage? = nil
            if bytes != nil {
                image = UIImage(data: bytes!)
                self.cinemaLogoImg.image = image
            }
            
        }
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let cineModel = CinemaModelView()
        
        let cineToSave = cinemaStruct(
            name: self.cinemaNameTextField.text!,
            image: self.cineImgUrl.text!,
            site: self.cinemaSiteTextField.text!
        )
        
        let addressToSave = addressStruct(
            street: self.cineAddressTextField.text!,
            number: Int(self.cineAddrNumberTextField.text!)!,
            cep: Int(self.cineAddrZipCodeTextField.text!)!,
            city: self.cineAddrCityTextField.text!,
            uf: self.cineAddrUfTextField.text!
        )
        
        if cineModel.createCinema(cine: cineToSave, address: addressToSave) {
            self.navigationController?.popViewController(animated: true)
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
