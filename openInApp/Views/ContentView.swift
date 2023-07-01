//
//  ContentView.swift
//  openInApp
//
//  Created by HD-045 on 12/06/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State private var selectedButton: SelectedButton = .topLinks
    @StateObject private var contentViewModel: ContentViewModel = ContentViewModel()
    @State private var greeting = ""
    
    var links: [TopLink]? {
        if selectedButton == .topLinks {
            return contentViewModel.topLinks
        } else if selectedButton == .recentLinks {
            return contentViewModel.recentLinks
        }
        return nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TopNavigationView()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(greeting)
                        .font(.callout)
                        .fontWeight(.light)
                        .onAppear {
                            let currentTime = Date()
                            self.greeting = contentViewModel.getGreeting(for: currentTime)
                        }
                    Text("Ajay Manva 👋")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    BarChartView(data: contentViewModel.chartData)
                    
                    TopListsView(topLists: contentViewModel.topLists)
                    
                    NavigationLink(destination: EmptyView()) {
                        CustomButton(imageName: "price-boost", title: "View Analytics")
                    }
                    
                    ButtonSection(selectedButton: $selectedButton)
                        
                    TopLinksView(topLinks: links)
                        .frame(height: 300)
                    
                    AdditionalButtonsView()
                }
                .padding()
                .background(Color("PrimaryWhite"))
                .cornerRadius(20)
                .padding(.bottom, -20)
            }
            
            BottomMenuBar()
        }
        .background(Color("PrimaryBlue"))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}











