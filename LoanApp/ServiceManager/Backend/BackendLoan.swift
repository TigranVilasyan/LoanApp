//
//  BackendLoan.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation

extension BackendRequest {
    
    func getLoan(complition: @escaping ([Loan]?) -> ()) {
        let request = LoanRequest.getLoan
        let headers = LoanRequest.getLoan.headers
        let url = URL(string: basePath + request.path)!
        BackendRequest.shared.requestWith(url: url, method: request.method,headers: headers) { resposne in
            do {
                let data = try JSONDecoder().decode([Loan].self, from: resposne as! Data)
                complition(data)
            } catch {
                print(error)
                complition(nil)
            }
        }
    }
}
