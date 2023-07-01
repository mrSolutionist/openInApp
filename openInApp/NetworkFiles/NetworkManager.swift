//
//  NetworkManager.swift
//  openInApp
//
//  Created by HD-045 on 13/06/23.
//
import Foundation
import Combine



class NetWorkManager{
    
    static let shared = NetWorkManager()
    private init(){}
    private var cancellables = Set<AnyCancellable>()
    let apiUrlString = "https://api.inopenapp.com/api/v1/dashboardNew"
    let authToken = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"

    
    func fetch(completion: @escaping (Result<OpenInAppDataModel, Error>) -> Void) {
        if let url = URL(string: apiUrlString) {
            var request = URLRequest(url: url)
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("Status code: \(response.statusCode)")
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(OpenInAppDataModel.self, from: data)
                        completion(.success(responseData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
    }
}

enum FetchError: Error {
    case invalidURL
    case apiError
}
