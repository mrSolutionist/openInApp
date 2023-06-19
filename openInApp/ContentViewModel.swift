//
//  ContentViewModel.swift
//  openInApp
//
//  Created by HD-045 on 13/06/23.
//

import Foundation
import Combine


struct TopList: Identifiable{
    var id: UUID
    var image: String
    var name: String
    var description : String
    let totalLinks, totalClicks, todayClicks: Int
    let topSource, topLocation, startTime: String
}

struct TopLink: Identifiable{
    var id: UUID
    var image: String
    var name: String
    var date : String
    var clicks: String
    var link: String
}


class ContentViewModel: ObservableObject{
    
    private var cancellables = Set<AnyCancellable>()
    @Published var fetchedData: OpenInAppDataModel?
    
   
    @Published var chartData: [DataPoint] = []
   @Published var topLists: TopList?
    @Published var topLinks: [TopLink] = []
    @Published var recentLinks: [TopLink] = []
    
  

    init(){
        fetchDetails()
    }
    
 
    func fetchDetails() {
        NetWorkManager.shared.fetch { result in
            switch result {
            case .success(let responseData):
                DispatchQueue.main.async {
                    // Map topLinks to your custom TopLink models
                    self.topLinks = responseData.data.topLinks.map {
                        TopLink(id: UUID(),
                                image: $0.originalImage,
                                name: $0.title,
                                date: $0.createdAt,
                                clicks: "\($0.totalClicks)",
                                link: $0.webLink)
                    }
                    
                    self.recentLinks = responseData.data.recentLinks.map {
                        TopLink(id: UUID(),
                                image: $0.originalImage,
                                name: $0.title,
                                date: $0.createdAt,
                                clicks: "\($0.totalClicks)",
                                link: $0.webLink)
                    }
                    
                    // Map other properties to your custom TopList model
                    self.topLists = TopList(id: UUID(),
                                            image: "", // Provide the appropriate value
                                            name: "", // Provide the appropriate value
                                            description: "", // Provide the appropriate value
                                            totalLinks: responseData.totalLinks,
                                            totalClicks: responseData.totalClicks,
                                            todayClicks: responseData.todayClicks,
                                            topSource: responseData.topSource,
                                            topLocation: responseData.topLocation,
                                            startTime: responseData.startTime)
                    
                    // Map other properties to your custom TopList model
                    self.chartData = responseData.data.overallURLChart.map { (date, value) in
                        DataPoint(date: date, value: value)
                    }

                }
                
            case .failure(let error):
                // Handle error
                print("Error: \(error)")
            }
        }
    }

     func getGreeting(for time: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        
        switch hour {
        case 0..<12:
            return "Good morning"
        case 12..<17:
            return "Good afternoon"
        default:
            return "Good evening"
        }
    }

    

}


struct DataPoint: Identifiable {
    let id = UUID()
    let date: String
    let value: Int
}

