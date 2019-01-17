//
//  APIManager.swift
//  LearnObjC
//
//  Created by ARIEL DIAZ on 1/2/19.
//  Copyright © 2019 ARIEL DIAZ. All rights reserved.
//

import Foundation

@objc class API: NSObject {
    
    @objc func post2API(WS: WebService, completion: @escaping(Any?) -> Void) {
        self.request(WS: WS, completion: { (response: SocioProTreeResponse?) in
            completion(response)
            
        })
    }
    
    func request<T: BaseMap>(WS: WebService, completion: @escaping(T?) -> Void) {
        let date: Date = Date()
        ActivityIndicatorManager.instance.progressViewWill(appear: true)
        DispatchQueue.global(qos: .background).async {
            let dataTask = URLSession.shared.dataTask(with: WS.urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    ActivityIndicatorManager.instance.progressViewWill(appear: false)
                    if let data = data as Data?,
                    let JSON = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON {
                        let time: TimeInterval = Date().timeIntervalSince(date)
                        debugPrint("THE REQUEST DURING: [\(time)] SECONDS")
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
