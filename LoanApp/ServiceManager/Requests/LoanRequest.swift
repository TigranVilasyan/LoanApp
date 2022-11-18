//
//  LoanRequest.swift
//  LoanApp
//
//  Created by Tigran VIasyan on 11.10.22.
//

import Foundation
import Alamofire

public enum LoanRequest: BackEndHelperRequest {
    case getLoan
    
    
    public var path: String {
        switch self {
        case .getLoan:
            return "/loan/steps/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getLoan:
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getLoan:
            return nil
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .getLoan:
            return ["x-device-id": "dd142c16-adbf-4226-9af9-3a77be356225"]
        }
    }
}
