//
//  Dependnecy.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import Swinject


class Dependency {
  
    var assembler: Assembler!
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    static var shared: Dependency = {
        return Dependency()
    }()
    
    
    func initalize() {
        self.assembler = Assembler([
            
            //ViewModels
            ViewModelAssembly(),
            //ViewControllers
            ViewControllerAssembly()
        ])
    }
}
