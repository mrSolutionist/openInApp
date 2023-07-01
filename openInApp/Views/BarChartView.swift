//
//  BarChartView.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import SwiftUI
import Charts

struct DataPoint: Identifiable {
    let id = UUID()
    let date: String
    let value: Int
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



struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: [DataPoint(date: "", value: 1)])
    }
}
