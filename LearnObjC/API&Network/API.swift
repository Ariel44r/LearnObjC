//
//  APIManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class API: NSObject {
    
    func request<T: BaseMap>(WS: WebService, completion: @escaping(T?) -> Void) {
        let date: Date = Date()
        ActivityIndicatorManager.instance.progressViewWill(.appear)
        DispatchQueue.global(qos: .background).async {
            let dataTask = URLSession.shared.dataTask(with: WS.urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    ActivityIndicatorManager.instance.progressViewWill(.disappear)
                    if let data = data as Data?,
                    let JSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON,
                    let json: JSON = JSON as JSON? {
                        debugPrint("THE REQUEST \(WS.name!) DURING: [\(Date().timeIntervalSince(date))] SECONDS")
                        let object = T.init()
                        object.map(map: json)
                        completion(object)

                    }
                }
            }
            dataTask.resume()
        }
    }
    
}
