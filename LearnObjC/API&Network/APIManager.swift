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
        self.request(
            WS: WebService(WS: .socioProTreeResponse, parameters, [:]),
            completion: { (response: SocioProTreeResponse?) in
                if let socioProTreeResponse = response as SocioProTreeResponse? {
                    completion(socioProTreeResponse)
                    
                }
            }
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
    
    func request<T: BaseMap>(WS: WebService, completion: @escaping(T?) -> Void) {
        let date: Date = Date()
        var request : URLRequest = URLRequest(url: URL(string: WS.requestURL)!)
        request.httpMethod = "post"
        request.httpBody = try? JSONSerialization.data(withJSONObject: WS.parameters, options: [])
        DispatchQueue.global(qos: .background).async {
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data as Data?,
                let JSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON {
                    let time: TimeInterval = Date().timeIntervalSince(date)
                    debugPrint("THE REQUEST DURING: [\(time)] SECONDS")
                    DispatchQueue.main.async {
                        let object = T.init()
                        object.map(map: JSON!)
                        debugPrint(object)
                        if let responseSocio = object as? SocioProTreeResponse {
                            debugPrint(responseSocio.empresas[0].getnEmpresa())
                            
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}
