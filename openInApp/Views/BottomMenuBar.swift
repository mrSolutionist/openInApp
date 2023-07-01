//
//  BottomMenuBar.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import SwiftUI

struct BottomMenuBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                   
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

struct BottomMenuBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomMenuBar()
    }
}
