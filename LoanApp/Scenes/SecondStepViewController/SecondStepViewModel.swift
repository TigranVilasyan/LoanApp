//
//  SecondStepViewModel.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 12.10.22.
//

import Foundation
import Swinject



protocol SecondStepViewModelInput: AnyObject {
    func viewDidLoad()
}


protocol SecondStepViewModelOutput: AnyObject {
    
}

protocol SecondStepViewModelType: AnyObject {
    var inputs: SecondStepViewModelInput { get }
    var outputs: SecondStepViewModelOutput { get }
}

class SecondStepViewModel: SecondStepViewModelInput,
                     SecondStepViewModelOutput,
                     SecondStepViewModelType {

    //MARK: Properties
    var inputs: SecondStepViewModelInput { return self }
    var outputs: SecondStepViewModelOutput { return self }
    
    
    //MARK: Output Methods
    
    //MARK: Input Methods
    func viewDidLoad() {
        
    }
    
}
