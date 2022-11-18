//
//  Controllers.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import UIKit


class Controllers {
    
    //MARK: RootViewController
    func rootViewController() -> FirstStepViewController {
        return controllerAt(identifier: "FirstStepViewController", storyBoard: "Main") as! FirstStepViewController
    }
    
    //MARK: SecondStepViewController
    func secondStepViewController() -> SecondStepViewController {
        return controllerAt(identifier: "SecondStepViewController", storyBoard: "Main") as! SecondStepViewController
    }
    
    //MARK: ThirdStepViewController
    func thirdStepViewController() -> ThirdStepViewController {
        return controllerAt(identifier: "ThirdStepViewController", storyBoard: "Main") as! ThirdStepViewController
    }
    
    //MARK: FourhStepViewController
    func fourthStepViewController() -> FourthStepViewController {
        return controllerAt(identifier: "FourthStepViewController", storyBoard: "Main") as! FourthStepViewController
    }
    
    //MARK: SelectionStepViewController
    func selectionStepViewController() -> SelectionViewController {
        return controllerAt(identifier: "SelectionViewController", storyBoard: "Main") as! SelectionViewController
    }
    
}

extension Controllers {
    func controllerAt(identifier: String,storyBoard: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: identifier)
        return vc
    }
}
