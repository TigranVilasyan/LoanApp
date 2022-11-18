//
//  SecondStepViewController.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 12.10.22.
//

import UIKit

class SecondStepViewController: BaseViewController, CheckValidationProtocol {
    
    
    //MARK: properties
    weak var viewModel: SecondStepViewModelType!
    var loan: [Loan]?
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: INJECTION
    func inejct(viewModel: SecondStepViewModelType) {
        self.viewModel = viewModel
    }
    
    //MARK: Methods
    override func dismissButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func nextButton(_ sender: Any) {
        let vc = Dependency.shared.resolver.resolve(ThirdStepViewController.self)!
        vc.loan = loan
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressStepView.progress = 0.5
        self.needToBeValid = ((loan?[1].fields.filter({$0.required == true}))!).count
        setupTableView()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup(loan: loan![1])
    }
    
    func setupTableView() {
        tableView.register(identifier: DatePickerFiledTableViewCell.identifier())
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
    
}

//MARK: TableViewDataSource
extension SecondStepViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loan?[1].fields.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerFiledTableViewCell.identifier(), for: indexPath) as? DatePickerFiledTableViewCell else { return UITableViewCell() }
        cell.setup(currentFiled: (loan?[1].fields[indexPath.row])!)
        cell.delegate = self
        return cell
    }
}
