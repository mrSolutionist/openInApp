//
//  TopNavigationView.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import SwiftUI

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

struct TopNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TopNavigationView()
    }
}
