//
//  ContentView.swift
//  openInApp
//
//  Created by HD-045 on 12/06/23.
//

import SwiftUI
import Charts

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    enum SelectedButton {
        case topLinks
        case recentLinks
        case search
    }
    
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

struct TopNavigationView: View {
    var body: some View {
        HStack {
            Text("Dashboard")
            
            Spacer()
            
            Image("NavButton")
        }
        .padding()
        .font(.title)
        .fontWeight(.semibold)
        .foregroundColor(.white)
    }
}

struct TopListsView: View {
    let topLists: TopList?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10)  {
                    Image("clickIcon")
                    Text("\(topLists?.totalClicks ?? 0)")
                        .fontWeight(.semibold)
                    Text("Today’s clicks")
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                .frame(width: 128, height: 128)
                .background(Color.white)
                
                VStack(alignment: .leading, spacing: 10) {
                    Image("locationIcon")
                    Text("\(topLists?.topLocation ?? "No Data")")
                        .fontWeight(.semibold)
                    Text("Top Location")
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                .frame(width: 128, height: 128)
                .background(Color.white)
                
                VStack(alignment: .leading, spacing: 10)  {
                    Image("globeIcon")
                    Text("\(topLists?.topSource ?? "No Data")")
                    
                    Text("Top source")
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                .frame(width: 128, height: 128)
                .background(Color.white)
            }
        }
    }
}

struct CustomButton: View {
    let imageName: String
    let title: String
    
    var body: some View {
        HStack {
            Spacer()
            Image(imageName)
            Text(title)
            Spacer()
        }
        .foregroundColor(.black)
        .font(.headline)
        .padding()
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}

struct ButtonSection: View {
    @Binding var selectedButton: ContentView.SelectedButton
    
    var body: some View {
        HStack {
            Button("Top Links") {
                selectedButton = .topLinks
            }
            .buttonStyle(.bordered)
            .background(selectedButton == .topLinks ? Color.blue : Color("PrimaryWhite"))
            .foregroundColor(selectedButton == .topLinks ? Color.white : Color.gray)
            .cornerRadius(10)
            
            Spacer()
            
            Button("Recent Links") {
                selectedButton = .recentLinks
            }
            .buttonStyle(.bordered)
            .background(selectedButton == .recentLinks ? Color.blue : Color("PrimaryWhite"))
            .foregroundColor(selectedButton == .recentLinks ? Color.white : Color.gray)
            .cornerRadius(10)
            
            Spacer()
            
            Button(action: {
                selectedButton = .search
            }) {
                Image("search")
            }
            .buttonStyle(.bordered)
            .background(selectedButton == .search ? Color.white : Color("PrimaryWhite"))
            .foregroundColor(selectedButton == .search ? Color.white : Color.gray)
            .cornerRadius(10)
        }
    }
}

struct TopLinksView: View {
    let topLinks: [TopLink]?
    
    var body: some View {
        List {
            ForEach(topLinks ?? []) { link in
                Section(header: Text("")) {
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string:link.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                case .failure(let error):
                                    Text("Failed to load image: \(error.localizedDescription)")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 48, height: 48)
                            
                            
                            VStack(spacing: 5) {
                                HStack {
                                    Text(link.name)
                                    Spacer()
                                    Text("\(link.clicks)")
                                }
                                .font(.footnote)
                                HStack {
                                    Text(link.date)
                                    Spacer()
                                    Text("Clicks")
                                }
                                .font(.caption)
                            }
                        }
                        
                    }
                    .listRowBackground(
                        Color.white
                            .clipped()
                            .padding(.bottom, 10)
                            .cornerRadius(10)
                            .padding(.bottom, -10)
                    )
                    
                    HStack {
                        Text(link.link)
                        Spacer()
                        Image(systemName: "doc.on.doc")
                    }
                    .font(.footnote)
                    .listRowBackground(
                        Color("SecondaryBlue")
                            .clipped()
                            .padding(.top, 10)
                            .cornerRadius(10)
                            .padding(.top, -10)
                    )
                }
                .listRowSeparator(.hidden)
            }
        }
        .frame(height: 300)
        .listStyle(.plain)
    }
}

struct AdditionalButtonsView: View {
    var body: some View {
        VStack(spacing: 30) {
            NavigationLink(destination: EmptyView()) {
                CustomButton(imageName: "link", title: "View Analytics")
            }
            
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image("whatsapp")
                    Text("Talk with us")
                    Spacer()
                }
                .foregroundColor(.black)
                .font(.headline)
                .padding()
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .background(Color("SecondaryGreen"))
            }
            
            NavigationLink(destination: EmptyView()) {
                HStack {
                    Image("question")
                    Text("Frequently Asked Questions")
                    Spacer()
                }
                .foregroundColor(.black)
                .font(.headline)
                .padding()
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .background(Color("SecondaryLightBlue"))
            }
        }
    }
}

struct BottomMenuBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Content View
                ZStack {
                    // Add your main content view here
                }
                
                // Bottom Menu
                VStack(spacing: 0) {
                    
                    
                    HStack {
                        TabItem(imageName: "link", title: "link", index: 0, selectedTab: $selectedTab)
                        
                        TabItem(imageName: "magazine", title: "Courses", index: 1, selectedTab: $selectedTab)
                        TabMainItem(imageName: "plus", index: 2, selectedTab: $selectedTab)
                            .offset(y:-10)
                        TabItem(imageName: "magazine", title: "Campaigns", index: 3, selectedTab: $selectedTab)
                        TabItem(imageName: "user", title: "Profile", index: 4, selectedTab: $selectedTab)
                    }
                    
                    .frame(height: 56)
                    .background(Color.white)
                    
                }
                
            }
        }
    }
}

struct TabItem: View {
    let imageName: String
    let title: String
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack(spacing: 4) {
                Image(imageName)
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == index ? .black : .gray)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
    }
}


struct TabMainItem: View {
    let imageName: String
    let index: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            ZStack {
                Circle()
                    .frame(width: 110,height: 80)
                    .foregroundColor(Color.white)
                
                Circle()
                    .frame(width: 60,height: 60)
                    .foregroundColor(Color("PrimaryBlue"))
                Image(imageName)
            }
            .foregroundColor(selectedTab == index ? .black : .gray)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
    }
}
struct BarChartView: View {
    var data: [DataPoint]
    
    var body: some View {
        
        Chart(data) {
           
              LineMark(
                x: .value("Date", $0.date),
                  y: .value("Value", $0.value)
              )
              .foregroundStyle(.blue)
          }
    }
}
