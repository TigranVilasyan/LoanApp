//
//  FourthStepViewModel.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 13.10.22.
//

import Foundation

protocol FourthStepViewModelInput: AnyObject {
    func viewDidLoad()
}


protocol FourthStepViewModelOutput: AnyObject {
    
}

protocol FourthStepViewModelType: AnyObject {
    var inputs: FourthStepViewModelInput { get }
    var outputs: FourthStepViewModelOutput { get }
}

class FourthStepViewModel: FourthStepViewModelInput,
                     FourthStepViewModelOutput,
                     FourthStepViewModelType {

    //MARK: Properties
    var inputs: FourthStepViewModelInput { return self }
    var outputs: FourthStepViewModelOutput { return self }
    
    
    //MARK: Output Methods
    
    
    
    //MARK: Input Methods
    func viewDidLoad() {
        
    }
    
}
