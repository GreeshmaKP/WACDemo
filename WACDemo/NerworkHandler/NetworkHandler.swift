//
//  NetworkHandler.swift
//  WACDemo
//
//  Created by Apple on 09/11/22.
//

import Foundation
import Alamofire


class NetworkHandler {
    
    static let sharedNetwork = NetworkHandler()
    
    private init() { }
    
    func networkCall(with url: String, completionHandler: @escaping (_ result: Data?, _ success: Bool, _ status: String) -> ()) {
        let url = URL(string: url)!
        var message = ""
        var status = Bool()
        AF.request(url, method: .post, parameters: nil)
            .responseJSON { response in
                print(response.value as Any)
                switch response.result {
                case .success(let responseData):
                    print(responseData)
                    let resp = response.value as! [String:Any]
                    status = resp["status"] as! Bool
                    
                    if status == true {
                        completionHandler(response.data, true, message)
                    } else {
                        completionHandler(response.data, false, message)
                    }
                case .failure(let networkErr):
                    switch networkErr {
                    case .responseSerializationFailed(reason: _):
                        message = "Something went wrong"
                    case .sessionTaskFailed(error: let err):
                        message = err.localizedDescription
                    default:
                        message = "Something went wrong"
                    }
                    completionHandler(nil, false, message)
                    break
                }
            }
    }
    
}
