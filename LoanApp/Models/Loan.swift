//
//  Loan.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation


// MARK: - Loan
struct Loan: Codable {
    let step: Int
    let fields: [Field]
}

// MARK: - Field
struct Field: Codable {
    let id: String
    let regex: String
    let type: String
    let name: String
    let hint: String
    let required: Bool
    let errorMessage: String
    let attributes: Attributes?
    let options: [String]?
}

// MARK: - Attributes
struct Attributes: Codable {
    let holidays: [Int]?
}
