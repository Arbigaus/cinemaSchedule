//
//  CinemaModelView.swift
//  cinemaSchedule
//
//  Created by Gerson Arbrugaus on 27/03/19.
//  Copyright © 2019 Arbigaus. All rights reserved.
//

import UIKit
import CoreData

class CinemaModelView  {
    private var CinemaList : [ Cinema ] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        let get : NSFetchRequest<Cinema> = Cinema.fetchRequest()
        
        do {
            CinemaList = try context.fetch(get)
        } catch {
            print("Erro: \(error)")
        }
        
//        let insertImax = cinemaStruct(name: "IMAX", image: "imax-logo.jpg")
//        let imaxAddress = addressStruct(cep: 80610905, number: 4121, street: "Av. Pres. Kennedy")
//
//        if createCinema(cine: insertImax, address: imaxAddress) {
//            print("Criado o cine: \(insertImax.name)")
//        }
//
//        let insertCinemax = cinemaStruct(name: "Cinemark", image: "cinemark.jpg")
//        let cinemarkAddress = addressStruct(cep: 80530060, number: 127, street: "Av. Cândido de Abreu")
//
//        if createCinema(cine: insertCinemax, address: cinemarkAddress) {
//            print("Criado o cine: \(insertCinemax.name)")
//        }
        
    }
    
    public func getCinemas() -> [ Cinema ] {
        return CinemaList
    }
    
    public func createCinema(cine : cinemaStruct, address : addressStruct) -> Bool {
        let cCinema = Cinema(context: context)
        
        cCinema.name = cine.name
        cCinema.image = cine.image
        
        do {
            try context.save()
            if createAddress(address: address, cine: cCinema) {
                return true
            } else {
                return false
            }
        } catch {
            print("Erro: \(error)")
            return false
        }
    }
    
    private func createAddress(address : addressStruct, cine : Cinema) -> Bool {
        let cAddress = CinemaAddress(context: context)
        
        cAddress.cep = Int32(address.cep)
        cAddress.number = Int16(address.number)
        cAddress.street = address.street
        cAddress.cinema = cine
        
        do {
            try context.save()
            return true
        } catch {
            print("Erro: \(error)")
            return false
        }
        
        
    }
}

struct cinemaStruct {
    var name  : String
    var image : String
}

struct addressStruct {
    var cep : Int
    var number : Int
    var street : String
}
