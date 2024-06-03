//
//  HoursForecast.swift
//  WeatherAppSwiftUI
//
//  Created by Israa Assem on 20/05/2024.
//

import SwiftUI

struct HoursForecast: View {
    var hours:[Hour]!
    var index = -1
    var isPM=false
    var body: some View {
        ZStack{
            if isPM{
               Image("Night")
            }else{
                Image("Day")
            }
            VStack{
                if(hours==nil){
                    Text("Loading...")
                }else{
                    ScrollView{
                    
                    ForEach(Array(hours.enumerated()), id: \.element.id) { (index, item) in
                        HoursRow(hour: item, index: index,isPM: isPM)
                    }
                }}
            }
        }
        
    }
}

#Preview {
    HoursForecast(hours: nil,isPM:false)
}


