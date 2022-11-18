//
//  BaseViewController.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import UIKit


enum KeyboardType: String {
    case FIELD_TEXT = "FIELD_TEXT"
    case FIELD_NUMBER = "FIELD_NUMBER"
}

class BaseViewController: UIViewController {
    
    var needToBeValid: Int = 0
    var isValid = [String:Bool]()
    var selectionDic = [Int: String]()
    
    @IBOutlet weak var progressStepView: UIProgressView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepCounter: UILabel!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bottomConstrain:NSLayoutConstraint!
    
    @IBAction func dismissButton(_ sender: Any) {
        
    }
    @IBAction func nextButton(_ sender: Any) {
    }
    func setup(loan: Loan) {
        stepLabel.text = "Step " + String(loan.step)
        stepCounter.text = String(loan.step) + "/4 steps"
    }
    
    override func viewDidLoad() {
        nextButton.isEnabled = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        super.viewDidLoad()
    }
    
}
