//
//  ThirdStepViewController.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 13.10.22.
//

import UIKit

class ThirdStepViewController: BaseViewController, CheckValidationProtocol {
    
    //MARK: Properties
    var viewModel: ThirdStepViewModelType!
    var loan: [Loan]?
    var isFirstTome: Bool = true
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: INJECTION
    func inejct(viewModel: ThirdStepViewModelType) {
        self.viewModel = viewModel
    }
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        progressStepView.progress = 0.75
        self.needToBeValid = ((loan?[2].fields.filter({$0.required == true}))!).count
        setupTableView()
        setupKeyboard()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup(loan: loan![2])
    }
    
    func setupTableView() {
        tableView.register(identifier: LoanFiledTableViewCell.identifier())
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func checkValidation(id: String, valid: Bool) {
        self.isValid[id] = valid
        if needToBeValid == isValid.filter({$1 == true}).count {
            nextButtonView.backgroundColor = .green
            nextButton.isEnabled = true
        } else {
            nextButtonView.backgroundColor = .lightGray
            nextButton.isEnabled = false
        }

    }
    
    func configCells(row: Int, text: String) {
        selectionDic[row] = text
    }
    
    override func nextButton(_ sender: Any) {
        let vc = Dependency.shared.resolver.resolve(FourthStepViewController.self)!
        vc.loan = loan
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func dismissButton(_ sender: Any) {
        let vc = Dependency.shared.resolver.resolve(SecondStepViewController.self)!
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
}

//MARK: TableViewDataSource
extension ThirdStepViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (loan?[2].fields.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoanFiledTableViewCell.identifier(), for: indexPath) as? LoanFiledTableViewCell else { return UITableViewCell() }
        cell.setup(currentFiled: (loan?[2].fields[indexPath.row])!,row: indexPath.row)
        if selectionDic.count != 0 {
            cell.currentLoanTextFiled.text = selectionDic[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
}
