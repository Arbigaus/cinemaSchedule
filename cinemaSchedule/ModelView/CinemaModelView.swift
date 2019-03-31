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
    private var SessionsList : [ Sessions ] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        let get : NSFetchRequest<Cinema> = Cinema.fetchRequest()
        let getSessions : NSFetchRequest<Sessions> = Sessions.fetchRequest()
        
        do {
            CinemaList = try context.fetch(get)
            SessionsList = try context.fetch(getSessions)
        } catch {
            print("Erro: \(error)")
        }
        

        
    }
    
    public func getCinemas() -> [ Cinema ] {
        return self.CinemaList
    }
    
    public func createCinema(cine : cinemaStruct, address : addressStruct) -> Bool {
        let cCinema = Cinema(context: context)
        
        cCinema.name  = cine.name
        cCinema.image = cine.image
        cCinema.site  = cine.site
        
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
        
        cAddress.cep    = Int32(address.cep)
        cAddress.number = Int16(address.number)
        cAddress.street = address.street
        cAddress.city   = address.city
        cAddress.uf     = address.uf
        cAddress.cinema = cine
        
        do {
            try context.save()
            return true
        } catch {
            print("Erro: \(error)")
            return false
        }
    }
    
    public func getSessions() -> [ Sessions ] {
        return self.SessionsList
    }
    
    public func createSession(session : sessionsStruct) -> Bool {
        let cSession = Sessions(context: context)
        
        cSession.room = session.room
        cSession.date = session.date
        cSession.cinema = session.cine
        cSession.movie = session.movie
        
        
        do {
            try context.save()
            return true
        } catch {
            print("Erro: \(error)")
            return false
        }        
    }
    
    public func createFirstCinemas() {
        let insertImax = cinemaStruct(name: "IMAX", image: "https://pmcvariety.files.wordpress.com/2014/07/imax-logo.jpg", site: "http://www.imaxpalladium.com.br")
        let imaxAddress = addressStruct(street: "Av. Pres. Kennedy", number: 4121, cep: 80610905, city: "Curitiba", uf: "PR")

        if createCinema(cine: insertImax, address: imaxAddress) {
            print("Criado o cine: \(insertImax.name)")
        }

        let insertCinemax = cinemaStruct(name: "Cinemark", image: "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/a5/f5/0a/a5f50a17-3fae-e747-94d3-5ed311a4f5a2/source/512x512bb.jpg", site: "http://www.cinemark.com.br")
        let cinemarkAddress = addressStruct(street: "Av. Cândido de Abreu", number: 127, cep: 80530060, city: "Curitiba", uf: "PR")

        if createCinema(cine: insertCinemax, address: cinemarkAddress) {
            print("Criado o cine: \(insertCinemax.name)")
        }
    }
    
}

struct cinemaStruct {
    var name  : String
    var image : String
    var site  : String
}

struct addressStruct {
    var street : String
    var number : Int
    var cep    : Int
    var city   : String
    var uf     : String
}

struct sessionsStruct {
    var room  : String
    var date  : Date
    var cine  : Cinema
    var movie : Movies
}

// Converter o objeto de sessãos para array
extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map({ $0 as! T})
        return array
    }
}

