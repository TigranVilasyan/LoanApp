//
//  ThirdStepViewModel.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 13.10.22.
//

import Foundation
import Swinject



protocol ThirdStepViewModelInput: AnyObject {
    func viewDidLoad()
}


protocol ThirdStepViewModelOutput: AnyObject {
    
}

protocol ThirdStepViewModelType: AnyObject {
    var inputs: ThirdStepViewModelInput { get }
    var outputs: ThirdStepViewModelOutput { get }
}

class ThirdStepViewModel: ThirdStepViewModelInput,
                     ThirdStepViewModelOutput,
                     ThirdStepViewModelType {

    //MARK: Properties
    var inputs: ThirdStepViewModelInput { return self }
    var outputs: ThirdStepViewModelOutput { return self }
    
    
    //MARK: Output Methods
    
    //MARK: Input Methods
    func viewDidLoad() {
        
    }
    
}
