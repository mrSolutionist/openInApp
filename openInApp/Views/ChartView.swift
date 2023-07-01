import SwiftUI

struct LineChartView: View {
    let chartData : [DataPoint] = [DataPoint(date: "", value: 0),DataPoint(date: "", value: 2),DataPoint(date: "", value: 3),DataPoint(date: "", value: 0),DataPoint(date: "", value: 5)]
    
    var body: some View {
        VStack {
            if chartData.isEmpty {
                Text("Loading...")
            } else {
                GeometryReader { geometry in
                    Path { path in
                        let dataPoints = chartData
                        let minValue = dataPoints.min { $0.value < $1.value }?.value ?? 0
                        let maxValue = dataPoints.max { $0.value < $1.value }?.value ?? 0
                        let xScale = geometry.size.width / CGFloat(dataPoints.count - 1)
                        let yScale = (geometry.size.height - 40) / CGFloat(maxValue - minValue)
                        
                        for (index, dataPoint) in dataPoints.enumerated() {
                            let x = CGFloat(index) * xScale
                            let y = (CGFloat(dataPoint.value) - CGFloat(minValue)) * yScale
                            
                            if index == 0 {
                                path.move(to: CGPoint(x: x, y: geometry.size.height - y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: geometry.size.height - y))
                            }
                        }
                    }
                    .stroke(Color.blue, lineWidth: 2)
                }
                .frame(height: 200)
                .padding(.horizontal, 16)
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView()
    }
}
