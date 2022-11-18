//
//  SelectionTableViewCell.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 14.10.22.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    static let identifier: String = "SelectionTableViewCell"
    
    @IBOutlet weak var selectedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
