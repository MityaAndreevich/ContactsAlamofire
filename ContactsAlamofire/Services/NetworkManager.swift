//
//  NetworkManager.swift
//  ContactsAlamofire
//
//  Created by Dmitry Logachev on 19.01.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case linkFor50 = "https://randomuser.me/api/?results=50"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchDataWithAlamofire( _ url: String, completion: @escaping(Result<[Contact], NetworkError>) -> Void) {
        AF.request(Link.linkFor50.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let results = Contact.getRandomContacts(from: value) else { return }
                   // DispatchQueue.main.async {
                        completion(.success(results))
                    //}
                case .failure(let error):
                    completion(.failure(.decodingError))
                    print(error)
                }
            }
    }
    
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
