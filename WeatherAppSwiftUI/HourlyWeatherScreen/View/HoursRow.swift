//
//  HoursRow.swift
//  WeatherAppSwiftUI
//
//  Created by Israa Assem on 20/05/2024.
//

import SwiftUI

struct HoursRow: View {
    var hour:Hour?
    var index=1
    var isPM=false
    var body: some View {
        let imageURL=URL(string:"https:"+((hour?.condition.icon)!))!
        HStack (spacing:20){
            if index == 0{
                if isPM{
                    Text("Now").foregroundColor(.white)
                }else{
                    Text("Now")}
            }else{
                if isPM{
                    Text("\(getTime24Hours(timeString: String((hour?.time)!.split(separator: " ")[1])))").foregroundColor(.white)
                }else{
                    Text("\(getTime24Hours(timeString: String((hour?.time)!.split(separator: " ")[1])))")
                }
            }
               AsyncImage(url: imageURL) { image in
                   image
                       .resizable().frame(width:60,height:60)
                       .aspectRatio(contentMode: .fit).padding(0)
               } placeholder: {
                   ProgressView()
               }
            if isPM{
                Text("\(Int((hour?.temp_c)!))°")
                    .foregroundColor(.white)
            }else{
                Text("\(Int((hour?.temp_c)!))°")
            }
            
            }
        
    }
}
func getTime24Hours(timeString:String)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let date = dateFormatter.date(from: timeString)
    dateFormatter.dateFormat = "h:mm a"
    return dateFormatter.string(from: date!)
}
#Preview {
    HoursRow(index: 1,isPM:false)
}
