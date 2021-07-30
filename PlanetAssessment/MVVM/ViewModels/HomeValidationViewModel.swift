//
//  HomeValidationViewModel.swift
//  PlanetAssessment
//
//  Created by Arnab on 30/07/21.
//

import Foundation
import UIKit
import CoreData

protocol HomeViewModelDelegate: NSObject {
    func savePlanetsDataSuccess()
    func savePlanetsDataFailedWithMessage(_ message: String)
}

class HomeValidationViewModel: NSObject {
    
    weak var delegate: HomeViewModelDelegate?
    
    init(_ delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func DeleteAllData(){
        let managedContext = CoreDataStorage.shared.managedObjectContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Planet"))
        do {
            try managedContext().execute(DelAllReqVar)
        }
        catch {
            print(error)
        }
    }
    
    func entityIsEmpty()
    {
        let context = CoreDataStorage.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Planet")
        do {
            let result = try context().fetch(fetchRequest)
            if result.isEmpty {
                self.delegate?.savePlanetsDataFailedWithMessage("Please Download The Data!")
                return
            } else {
                self.delegate?.savePlanetsDataSuccess()
            }
        } catch {
            print(error)
        }
    }
}
