//
//  TopListModel.swift
//  openInApp
//
//  Created by HD-045 on 30/06/23.
//

import Foundation
struct TopList: Identifiable{
    var id: UUID
    var image: String
    var name: String
    var description : String
    let totalLinks, totalClicks, todayClicks: Int
    let topSource, topLocation, startTime: String
}
