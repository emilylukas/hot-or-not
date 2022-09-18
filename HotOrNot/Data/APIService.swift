//
//  APIService.swift
//  HotOrNot
//
//  Created by Emily L on 2022-09-17.
//
import Foundation
import UIKit

enum PostError: Error {
        case invalidURL
        case failedRequest
        case serializationError
}

class APIService {
    let baseUrl = String(format: "http://3.95.165.101:5000/image")
    var response: Any? = nil
    
    func postRequest(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        print("calling postRequest")
        guard let serviceUrl = URL(string: baseUrl) else { return }
        let params: [String: Any] = [:]
        let request = MultipartFormDataRequest(url: serviceUrl)
        print("our image data")
        print(imageData)
        request.addDataField(named: "file", data: imageData, mimeType: "img/jpeg")
        let session = URLSession.shared
        session.dataTask(with: request.asURLRequest()) { (data, response, error) in
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
    
    /*func postRequest(imageData: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        guard let serviceUrl = URL(string: baseUrl) else { return }
        var urlRequest = URLRequest(url: serviceUrl)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()
        let fileName = "HotOrNotImage_" + Double.random(in: 0..<1).formatted()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg".data(using: .utf8)!)
        data.append(imageData.jpegData(compressionQuality: 1.0)!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if let response = response {
                //print(response)
            }
            if let responseData = responseData {
                do {
                    print("we have data")
                    let responseString = String(decoding: data, as: UTF8.self)
                    // print(responseString)
                    self.response = responseString
                    completion(.success(responseString))
                }
            }
            else {
                    print("post failed")
                    //print(error)
                    completion(.failure(PostError.failedRequest))
            }
        }).resume()
    }*/
    
    func requestNativeImageUpload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let boundary = "Boundary-\(NSUUID().uuidString)"
        guard let serviceUrl = URL(string: baseUrl) else { return }
        var request = URLRequest(url: serviceUrl)

        guard let mediaImage = Media(withImage: image, forKey: "file") else { return }

        request.httpMethod = "POST"

        request.allHTTPHeaderFields = [
                    "X-User-Agent": "ios",
                    "Accept-Language": "en",
                    "Accept": "*/*",
                    "Content-Type": "multipart/form-data; boundary=\(boundary)",
                ]

        let dataBody = createDataBody(media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody

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

    func createDataBody(media: [Media]?, boundary: String) -> Data {

        let lineBreak = "\r\n"
        var body = Data()

        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }

        body.append("--\(boundary)--\(lineBreak)")

        return body
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String

    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"

        guard let data = image.jpegData(compressionQuality: 0.1) else { return nil }
        self.data = data
    }
}
