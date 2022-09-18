//
//  APIService.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//
import Foundation

enum PostError: Error {
        case invalidURL
        case failedRequest
        case serializationError
}

class APIService {
    let baseUrl = String(format: "http://44.204.2.67:5000/testpost")
    var response: Any? = nil
    
    func postRequest(completion: @escaping (Result<String, Error>) -> Void) {
        print("calling postRequest")
        guard let serviceUrl = URL(string: baseUrl) else { return }
        /*let parameters: [String: Any] = [
            "request": [
                    "xusercode" : "YOUR USERCODE HERE",
                    "xpassword": "YOUR PASSWORD HERE"
            ]
        ]*/
        let params: [String: Any] = [:]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            print("post did not work")
            completion(.failure(PostError.serializationError))
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    print("we have data")
                    let responseString = String(decoding: data, as: UTF8.self)
                    print(responseString)
                    self.response = responseString
                    completion(.success(responseString))
                }
            }
            else {
                    print("post failed")
                    print(error)
                    completion(.failure(PostError.failedRequest))
            }
        }.resume()
    }
}
