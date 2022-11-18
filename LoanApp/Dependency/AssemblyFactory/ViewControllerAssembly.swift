//
//  ViewControllerAssembly.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FirstStepViewController.self) { r in
            let vc = Controllers().rootViewController()
            let viewModel = container.resolve(FirstStepViewModelType.self)!
            vc.inejct(viewModel: viewModel)
            return vc
        }.inObjectScope(.container)
        
        container.register(SecondStepViewController.self) { r in
            let vc = Controllers().secondStepViewController()
            let viewModel = container.resolve(SecondStepViewModelType.self)!
            vc.inejct(viewModel: viewModel)
            return vc
        }.inObjectScope(.container)
        
        container.register(ThirdStepViewController.self) { r in
            let vc = Controllers().thirdStepViewController()
            let viewModel = container.resolve(ThirdStepViewModelType.self)!
            vc.inejct(viewModel: viewModel)
            return vc
        }.inObjectScope(.container)
        
        container.register(FourthStepViewController.self) { r in
            let vc = Controllers().fourthStepViewController()
            let viewModel = container.resolve(FourthStepViewModelType.self)!
            vc.inejct(viewModel: viewModel)
            return vc
        }.inObjectScope(.container)
        
        container.register(SelectionViewController.self) { r in
            let vc = Controllers().selectionStepViewController()
            return vc
        }.inObjectScope(.container)
    }
}
