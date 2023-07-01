//
//  CustomButton.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import SwiftUI

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
    @Binding var selectedButton: SelectedButton
    
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
struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(imageName: "", title: "")
    }
}
