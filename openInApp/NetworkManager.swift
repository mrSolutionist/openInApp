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
        func fetchData() -> Future<[OpenInAppDataModel],Error>{
            
            return Future<[OpenInAppDataModel],Error> { [weak self] promise in
                
                guard let self =  self, let apiUrl = URL(string: apiUrlString) else {
                           print("Invalid API URL")
                    return promise(.failure(FetchError.invalidURL))
                       }
                var request = URLRequest(url: apiUrl)
                request.addValue(authToken, forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTaskPublisher(for: request)
              
                
                    .tryMap { (data: Data, response: URLResponse) in
                        guard let httpResp = response as? HTTPURLResponse else {
                            throw FetchError.apiError
                        }
                        
                        return data
                    }
                    .decode(type: [OpenInAppDataModel].self, decoder: JSONDecoder())
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: {(completion) in
                        if case let .failure(error) = completion{
                            switch error{
                            case let decodeError as DecodingError:
                                promise(.failure(decodeError))
                            case let apiError as FetchError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(FetchError.invalidURL))
                            }
                        }
                    }, receiveValue: {promise(.success($0))})
                    .store(in: &self.cancellables)
            }        
        }
    }
enum FetchError: Error {
    case invalidURL
    case apiError
}
