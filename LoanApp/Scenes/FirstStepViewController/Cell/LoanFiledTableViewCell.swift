//
//  loanFiledTableViewCell.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import UIKit

class LoanFiledTableViewCell: UITableViewCell {
    
    var filed: Field?
    weak var delegate: CheckValidationProtocol?
    weak var selectionViewdelegate: OpenSelectionPorotocol?
    var row: Int = 0
    var keyboardType: KeyboardType = .FIELD_TEXT
    
    
    @IBOutlet weak var filedTitleLabel: UILabel!
    
    @IBOutlet weak var validationLabel: UILabel!
    @IBOutlet weak var currentLoanTextFiled: UITextField!
    
    class func identifier() -> String {
        return "LoanFiledTableViewCell"
    }
    @IBAction func currentLoanTextFiled(_ sender: Any) {
        if selectionViewdelegate != nil {
            selectionViewdelegate?.presentModal(name: (filed?.name)!, options: (filed?.options)!,row: row)
        } else {
            delegate?.configCells(row: row, text: currentLoanTextFiled.text!)
        }
    }
    
    func hideKeyboard() {
        //It will Hide Keyboard
        currentLoanTextFiled.inputView = UIView()
        //It will Hide Keyboard tool bar
        currentLoanTextFiled.inputAccessoryView = UIView()
        //It will Hide the cursor
        currentLoanTextFiled.tintColor = .white
    }
    
    func setup(currentFiled: Field,row: Int = 0) {
        self.filed = currentFiled
        self.row = row
        currentLoanTextFiled.placeholder = currentFiled.hint
        validationLabel.text = currentFiled.errorMessage
        if let type = KeyboardType(rawValue: currentFiled.type) {
            keyboardType = type
        }
        if currentFiled.required {
            filedTitleLabel.text = currentFiled.name
        } else {
            filedTitleLabel.text = currentFiled.name + " (optional)"
        }
    }
    
    func validate(text: String, with regex: String) -> Bool {
        // Create the regex
        guard let gRegex = try? NSRegularExpression(pattern: regex) else {
            return false
        }
        
        // Create the range
        let range = NSRange(location: 0, length: text.utf16.count)
        
        // Perform the test
        if gRegex.firstMatch(in: text, options: [], range: range) != nil {
            return true
        }
        return false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        currentLoanTextFiled.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func checkValidation(text: String) {
        if text == "" {
            validationLabel.isHidden = true
        }
    }
}

extension LoanFiledTableViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        validationLabel.isHidden = validate(text: text, with: filed!.regex)
        if (filed?.required == true) {
            delegate?.checkValidation(id: filed!.id,valid: validationLabel.isHidden)
        }
        delegate?.configCells(row: row, text: currentLoanTextFiled.text!)
        checkValidation(text: text)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch keyboardType {
        case .FIELD_TEXT:
            textField.keyboardType = .alphabet
        case .FIELD_NUMBER:
            textField.keyboardType = .asciiCapableNumberPad
        }
        validationLabel.isHidden = validate(text: text, with: filed!.regex)
        if (filed?.required == true) {
//            validationLabel.isHidden = validate(text: text, with: filed!.regex)
            delegate?.checkValidation(id: filed!.id,valid: validationLabel.isHidden)
        }
        delegate?.configCells(row: row, text: currentLoanTextFiled.text!)
        checkValidation(text: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.contentView.endEditing(true)
        return false
    }
}
