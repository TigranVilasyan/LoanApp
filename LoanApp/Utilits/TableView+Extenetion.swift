//
//  TableView+Extenetion.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(identifier: String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
