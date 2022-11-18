//
//  SelectionViewController.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 14.10.22.
//

import UIKit

class SelectionViewController: UIViewController {

    //MARK: Properties
    var options = [String]()
    var selctionTitle = " "
    var row = 0
    var loan: Loan?
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: methods
    func setupTableView() {
        tableView.register(identifier: "SelectionTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = selctionTitle
        tableView.reloadData()
    }
}

//MARK: TableViewDataSource
extension SelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.identifier, for: indexPath) as? SelectionTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.selectedLabel.text = options[indexPath.row]
        return cell
    }
}

//MARK: TableViewDelegate
extension SelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = Dependency.shared.resolver.resolve(FourthStepViewController.self)!
        vc.filedTitle = options[indexPath.row]
        vc.checkValidation(id: (loan?.fields[3].id)!, valid: true)
        dismiss(animated: true)
        vc.tableView.reloadData()
    }
}
