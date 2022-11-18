//
//  BackendRequest.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import Alamofire


class BackendRequest {
    
    static var shared = BackendRequest()
    let basePath = "https://dolphin-app-2fcvg.ondigitalocean.app/api/v1"
    //MARK: -`AF request`
    func requestWith(url: URL, method: HTTPMethod, params: Parameters? = nil, headers: HTTPHeaders? = nil, complatation: @escaping (Any) -> ()) {
        AF.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200...600)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                    complatation(error)
                case .success(_):
                    complatation(response.data)
                }
            }
    }
}
