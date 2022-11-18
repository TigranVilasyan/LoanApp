//
//  ViewModelAssembly.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import Swinject


class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FirstStepViewModelType.self) { r in
            return FirstStepViewModel()
        }.inObjectScope(.container)
        
        container.register(SecondStepViewModelType.self) { r in
            return SecondStepViewModel()
        }.inObjectScope(.container)
        
        container.register(ThirdStepViewModelType.self) { r in
            return ThirdStepViewModel()
        }.inObjectScope(.container)
        
        
        container.register(FourthStepViewModelType.self) { r in
            return FourthStepViewModel()
        }.inObjectScope(.container)
        
    }
}
