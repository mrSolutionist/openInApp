//
//  TopListsView.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import SwiftUI

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

struct TopListsView_Previews: PreviewProvider {
    static var previews: some View {
        TopListsView(topLists: TopList(id: UUID(), image: "", name: "", description: "", totalLinks: 2, totalClicks: 85, todayClicks: 5, topSource: "", topLocation: "", startTime: ""))
    }
}
