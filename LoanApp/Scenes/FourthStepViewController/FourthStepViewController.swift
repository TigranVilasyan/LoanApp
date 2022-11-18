//
//  FourthStepViewController.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 13.10.22.
//

import UIKit

protocol OpenSelectionPorotocol: AnyObject {
    func presentModal(name: String, options: [String],row: Int)
}

class FourthStepViewController: BaseViewController,OpenSelectionPorotocol, CheckValidationProtocol {

    //MARK: Properties
    var viewModel: FourthStepViewModelType!
    var loan: [Loan]?
    var filedTitle: String = ""
    var row: Int?
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: INJECTION
    func inejct(viewModel: FourthStepViewModelType) {
        self.viewModel = viewModel
    }
    
    //MARK: Methods
    func setupTableView() {
        tableView.register(identifier: LoanFiledTableViewCell.identifier())
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressStepView.progress = 1
        self.needToBeValid = ((loan?[3].fields.filter({$0.required == true}))!).count
        setupTableView()
        tableView.reloadData()
    }
    
    func checkValidation(id: String, valid: Bool) {
        self.isValid[id] = valid
        if needToBeValid == isValid.count {
            nextButtonView.backgroundColor = .green
            nextButton.isEnabled = true
        } else {
            nextButtonView.backgroundColor = .lightGray
            nextButton.isEnabled = false
        }
    }
    
    
    override func dismissButton(_ sender: Any) {
        let vc = Dependency.shared.resolver.resolve(ThirdStepViewController.self)!
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup(loan: loan![3])
    }
    
    func presentModal(name: String, options: [String],row: Int) {
        let vc = Dependency.shared.resolver.resolve(SelectionViewController.self)!
        vc.options = options
        vc.selctionTitle = name
        vc.loan = loan![3]
        self.row = row
        let nav = UINavigationController(rootViewController: vc)
        // 1
        nav.modalPresentationStyle = .pageSheet
        // 2
        if let sheet = nav.sheetPresentationController {

            // 3
            let size = CGFloat(60 * (options.count+1))
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom { _ in
                        return size
                    }
                ]
            } else {
                // Fallback on earlier versions
            }
        }
        // 4
        present(nav, animated: true, completion: nil)

    }
}

//MARK: TableViewDataSource
extension FourthStepViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loan?[3].fields.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoanFiledTableViewCell.identifier(), for: indexPath) as? LoanFiledTableViewCell else { return UITableViewCell() }
        if let row = row {
            selectionDic[row] = filedTitle
            cell.currentLoanTextFiled.text = selectionDic[indexPath.row]
        }
        cell.setup(currentFiled: (loan?[3].fields[indexPath.row])!,row: indexPath.row)
        cell.hideKeyboard()
        cell.delegate = self
        cell.selectionViewdelegate = self
        return cell
    }
}

