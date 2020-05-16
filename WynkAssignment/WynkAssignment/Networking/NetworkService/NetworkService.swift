//
//  NetworkService.swift
//  WynkAssignment
//
//  Created by Admin on 16/05/20.
//  Copyright © 2020 Nitin Singh Rathore. All rights reserved.
//

import UIKit

//MARK:- NetworkService Protocol to hit a service
protocol NetworkServiceProtocol {
    
    func webRequest(_ endPoint: AppRouter, _ success: @escaping(Data) -> Void, _ failure: @escaping(Error) -> Void)
}

//MARK:- NetworkService class to hit web services
class NetworkService: NetworkServiceProtocol {
    
    let reachability = try! Reachability()
    
    init() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
    
    func webRequest(_ endPoint: AppRouter, _ success: @escaping (Data) -> Void, _ failure: @escaping (Error) -> Void) {
        
        let request = NSMutableURLRequest(url: endPoint.getURL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = endPoint.getHTTPMethod
        
        let headers = ["Content-Type": "application/json",
                       "Accept": "application/json"]
        print(endPoint.getURL)
        request.allHTTPHeaderFields = headers
        
        if reachability.connection == .unavailable {
            request.cachePolicy = .returnCacheDataDontLoad
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest,
                                        completionHandler: { [weak self] (data, response, error) -> Void in
                                            if error != nil, let error = error {
                                                failure(error)
                                            } else if let data = data {
                                                success(data)
                                            }
                                            self?.handleNetworkActivityIndicator(false)
        })
        handleNetworkActivityIndicator(true)
        dataTask.resume()
    }
    
    private func handleNetworkActivityIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
    }
}
