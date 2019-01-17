//
//  APIManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

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
                        completion(object)
                        
                    }
                }
            }
            dataTask.resume()
        }
    }
    
}
