//
//  TopLinksView.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import SwiftUI

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

struct TopLinksView_Previews: PreviewProvider {
    static var previews: some View {
        TopLinksView(topLinks: [TopLink(id: UUID(), image: "", name: "", date: "", clicks: "", link: "")])
    }
}
