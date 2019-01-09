//
//  APIManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

@objc class APIManager: NSObject {
    
    // MARK: - SocioProTreeResponse
    @objc func getSocioProTree(parameters: [String: Any], completion: @escaping(SocioProTreeResponse) -> Void) {
        self.endPoint(
            request: WebService(WS: .socioProTreeResponse, parameters, [:]),
            completion: { (response: SocioProTreeResponse?) in
                if let socioProTreeResponse = response as SocioProTreeResponse? {
                    debugPrint(socioProTreeResponse.toJSON())
                    completion(socioProTreeResponse)
                    
                }
            }
        )
    }
    
    // MARK: Login
    @objc func loginWS(parameters: [String: Any], completion: @escaping(BaseResponse?) -> Void) {
        self.endPoint(
            request: WebService(WS: .login, parameters, [:]),
            completion: { response in completion(response) }
            
        )
    }
    
    @objc func signUpWS(parameters: [String: Any], completion: @escaping(BaseResponse?) -> Void) {
        self.endPoint(
            request: WebService(WS: .signUp, parameters, [:]),
            completion: { response in completion(response) }
            
        )
    }
    
    // MARK: EndPoint (all request pass through here)
    func endPoint<T: Mappable>(request: WebService, completion: @escaping(T?) -> Void) {
        debugPrint("\u{1F436} \(request.name ?? "name")")
        debugPrint("URL: \(request.requestURL ?? "requestURL")")
        debugPrint("HEADERS: \(request.headers ?? [:])")
        debugPrint("PARAMETERS: \(request.parameters)")
        if NetworkReachabilityManager()!.isReachable {
            if request.showActivityViewWhileRequest {
                ActivityIndicatorManager.instance.progressViewWill(appear: true)
                
            }
            Alamofire.request(request.requestURL, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers).validate().responseObject(completionHandler: { (response: DataResponse<T>) in
                ActivityIndicatorManager.instance.progressViewWill(appear: false)
                switch response.result {
                case .success:
                    debugPrint("✔️ -> [\(request.name!)]")
                    completion(response.value!)
                    
                case .failure(let error):
                    debugPrint("❌ -> [\(request.name!)] -> ", error)
                    if error.localizedDescription.contains("The request timed out") {
                        AlertControllerManager.showAlert(controller: nil, alertStyle: .alert, title: "Localizable.Common.TROUBLE_CONNECTION", message: "Localizable.Common.FAILURE_SERVER_CONNECTION", actions: nil)
                        
                    }
                    completion(nil)
                    
                }
            })
        } else {
            AlertControllerManager.showAlert(controller: nil, alertStyle: .alert, title: "Localizable.Common.TROUBLE_CONNECTION", message: "Localizable.Common.FAILURE_SERVER_CONNECTION", actions: nil)
            completion(nil)
            
        }
    }
    
}
