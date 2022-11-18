//
//  FirstStepViewController.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import UIKit

protocol CheckValidationProtocol: AnyObject {
    func checkValidation(id: String,valid: Bool)
    func configCells(row:Int,text: String)
}

extension CheckValidationProtocol {
    func configCells(row:Int,text: String) {
        
    }
}

class FirstStepViewController: BaseViewController,CheckValidationProtocol {
    
    //MARK: Properties
    weak var viewModel: FirstStepViewModelType!
    var loan: [Loan]?
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: INJECTION
    func inejct(viewModel: FirstStepViewModelType) {
        self.viewModel = viewModel
    }
    
    //MARK: Methods
    func setupTableView() {
        tableView.register(identifier: LoanFiledTableViewCell.identifier())
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func checkValidation(id: String,valid: Bool) {
        self.isValid[id] = valid
        if needToBeValid == isValid.filter({$1 == true}).count {
            nextButtonView.backgroundColor = .green
            nextButton.isEnabled = true
        } else {
            nextButtonView.backgroundColor = .darkGray
            nextButton.isEnabled = false
        }
    }
    
    func configCells(row: Int, text: String) {
        selectionDic[row] = text
    }
    
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var isFirstTome: Bool = true
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if isFirstTome {
                bottomConstrain.constant += 300
                isFirstTome = false
            }
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + tableView.rowHeight, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomConstrain.constant = 48
        isFirstTome = true
        tableView.contentInset = .zero
    }
    
    override func nextButton(_ sender: Any) {
        let vc = Dependency.shared.resolver.resolve(SecondStepViewController.self)!
        vc.loan = loan
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressStepView.progress = 0.25
        setupTableView()
        setupKeyboard()
        viewModel.outputs.getLoan { [weak self] loan in
            self?.loan = loan
            self?.needToBeValid = ((loan?[0].fields.filter({$0.required == true}))!).count
            self?.setup(loan: (loan?[0])!)
            self?.tableView.reloadData()
        }
    }
}

//MARK: TableViewDataSource
extension FirstStepViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loan?[0].fields.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoanFiledTableViewCell.identifier(), for: indexPath) as? LoanFiledTableViewCell else { return UITableViewCell() }
        cell.setup(currentFiled: (loan?[0].fields[indexPath.row])!,row: indexPath.row)
        if selectionDic.count != 0 {
            cell.currentLoanTextFiled.text = selectionDic[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
}
