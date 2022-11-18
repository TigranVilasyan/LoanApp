//
//  DatePickerFiledTableViewCell.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 12.10.22.
//

import UIKit

class DatePickerFiledTableViewCell: LoanFiledTableViewCell {
    
    override class func identifier() -> String {
        return "DatePickerFiledTableViewCell"
    }
    var picker: UIDatePicker?
    @IBOutlet weak var datePickerButton: UIButton!
    
    
    @IBAction func datePickerButton(_ sender: Any) {
  
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPicker()
        
    }
    
    
        
        func formatDate(date: Date) -> String
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.string(from: date)
        }
    
    override func setup(currentFiled: Field,row: Int = 0) {
        super.setup(currentFiled: currentFiled)
//        filedTitleLabel.text = currentFiled.name
    }
    
    func setupPicker() {
        
        let datePicker = UIDatePicker()
        currentLoanTextFiled.inputView = datePicker //Change your textfield name
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        //Write toolbar code for done button
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        currentLoanTextFiled.inputAccessoryView = toolBar
        self.picker = datePicker
    }
    
    //Toolbar done button function
    @objc func onClickDoneButton() {
        validationLabel.isHidden = validate(text: formatDate(date: picker!.date), with: filed!.regex)
        currentLoanTextFiled.text = formatDate(date: picker!.date)
        self.contentView.endEditing(true)
        delegate?.checkValidation(id: filed!.id,valid: validationLabel.isHidden)
    
    }
}
