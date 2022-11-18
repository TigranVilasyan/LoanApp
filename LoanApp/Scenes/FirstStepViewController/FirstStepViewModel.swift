//
//  FirstStepViewViewModel.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import Swinject



protocol FirstStepViewModelInput: AnyObject {
    func viewDidLoad()
}


protocol FirstStepViewModelOutput: AnyObject {
    func getLoan(complition: @escaping ([Loan]?) -> ())
}

protocol FirstStepViewModelType: AnyObject {
    var inputs: FirstStepViewModelInput { get }
    var outputs: FirstStepViewModelOutput { get }
}

class FirstStepViewModel: FirstStepViewModelInput,
                     FirstStepViewModelOutput,
                     FirstStepViewModelType {

    //MARK: Properties
    var inputs: FirstStepViewModelInput { return self }
    var outputs: FirstStepViewModelOutput { return self }
    
    
    //MARK: Output Methods
    func getLoan(complition: @escaping ([Loan]?) -> ()) {
        BackendRequest().getLoan { [weak self] data in
            if let data = data {
                complition(data)
            }
        }
    }
    
    //MARK: Input Methods
    func viewDidLoad() {
        
    }
    
}
