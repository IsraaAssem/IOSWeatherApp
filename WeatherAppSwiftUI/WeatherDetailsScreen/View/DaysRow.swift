//
//  DaysRow.swift
//  WeatherAppSwiftUI
//
//  Created by Israa Assem on 20/05/2024.
//

import SwiftUI

struct DaysRow: View {
    var day:ForecastDay!
    var isPM=false
    var body: some View {
        let imageURL=URL(string:"https:"+((day?.day.condition.icon)!))!
        VStack{
            ThickDivider()
            HStack(spacing:45){
                if getCurrentDay() == day!.date{
                    if isPM{
                        Text("Today").font(.system(size: 20))
                            .foregroundColor(.white)
                    }else{
                        Text("Today").font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }else{
                    if isPM{
                        Text("\(getDayName(dayBeforeFormat: day!.date))").font(.system(size: 20))
                            .foregroundColor(.white)
                    }else{
                        Text("\(getDayName(dayBeforeFormat: day!.date))").font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                if isPM{
                    Text("\(Int((day?.day.mintemp_c)!))° - \(Int((day?.day.maxtemp_c)!))°")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }else{
                    Text("\(Int((day?.day.mintemp_c)!))° - \(Int((day?.day.maxtemp_c)!))°")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                
                    

            }
        }
    }
}

struct ThickDivider: View {
    var body: some View {
        Rectangle()
            .frame(width:300,height: 2)
            .foregroundColor(.gray)
    }
}
func getCurrentDay()->String{
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: currentDate)
}
#Preview {
    DaysRow(day: nil,isPM:false)
}
