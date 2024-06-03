//
//  DetailScreenView.swift
//  WeatherAppSwiftUI
//
//  Created by Israa Assem on 20/05/2024.
//

import SwiftUI
import Foundation
struct DetailScreenView: View {
    @StateObject private var detailsViewModel=DetailsViewModel()
    let imageURL=URL(string:"https://cdn.weatherapi.com/weather/64x64/day/113.png")!
    
    var body: some View {
        var fontColor=Color.black
        if detailsViewModel.weatherResponse == nil {
            Text("Loading....")
        }
        else{
            NavigationView{
                ZStack{
                    let isPM = getTime24Hours(timeString: String((detailsViewModel.weatherResponse?.location.localtime)!.split(separator: " ")[1])).contains("PM")
                    if isPM {
                        Image("Night")
                            .foregroundColor(.white) // Set font color here
                    } else {
                        Image("Day")
                    }
                    
                    VStack{
                        VStack(spacing:50){
                            VStack{
                                if isPM{
                                    Text(detailsViewModel.weatherResponse?.location.name ?? "Assiut")
                                        .bold()
                                        .font(.title)
                                        .foregroundColor(.white)
                                }else{
                                    Text(detailsViewModel.weatherResponse?.location.name ?? "Assiut")
                                        .bold()
                                        .font(.title)
                                }
                                if isPM{
                                    Text("21")
                                        .bold()
                                        .font(.title).foregroundColor(.white)
                                }else{
                                    Text("21")
                                        .bold()
                                        .font(.title)
                                }
                                if isPM{
                                    Text(detailsViewModel.weatherResponse?.current.condition.text ?? "Cloudy")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white)
                                }else
                                {
                                    Text(detailsViewModel.weatherResponse?.current.condition.text ?? "Cloudy")
                                        .font(.title)
                                        .bold()
                                }
                                HStack{
                                   if isPM {
                                        Text("H: \(Int((detailsViewModel.weatherResponse?.forecast.forecastday[0].day)!.maxtemp_c))°  -   L: \(Int((detailsViewModel.weatherResponse?.forecast.forecastday[0].day)!.mintemp_c))°")
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(.white)
                                    }else{
                                        Text("H: \(Int((detailsViewModel.weatherResponse?.forecast.forecastday[0].day)!.maxtemp_c))°  -   L: \(Int((detailsViewModel.weatherResponse?.forecast.forecastday[0].day)!.mintemp_c))°")
                                            .font(.title)
                                            .bold()
                                    }
                                }
                                AsyncImage(url: URL(string: "https:"+(detailsViewModel.weatherResponse?.current.condition.icon)!)!) { image in
                                    image
                                        .resizable().frame(width:60,height:60)
                                        .aspectRatio(contentMode: .fit).padding(0)
                                } placeholder: {
                                    ProgressView()
                                }
                                
                            }
                            VStack(alignment:.leading){
                                if isPM{
                                    Text("3-DAY FORECAST")
                                        .foregroundColor(.white)
                                }else{
                                    Text("3-DAY FORECAST")
                                }
                               
                                
                                if let forecastDays = detailsViewModel.weatherResponse?.forecast.forecastday {
                                    ForEach(forecastDays , id: \.id) {item in
                                        NavigationLink(destination: HoursForecast(hours: item.hour,isPM:isPM)) {
                                            DaysRow(day: item as! ForecastDay ,isPM: isPM)
                                        }
                                    }
                                } else {
                                    Text("No forecast available")
                                }
                                
                            }.padding(.horizontal,20)
                        }
                        HStack{
                            VStack{
                                if isPM{
                                    Text("VISIBILITY")
                                        .padding(.bottom,5)
                                        .foregroundColor(.white)
                                }else{
                                    Text("VISIBILITY")
                                        .padding(.bottom,5)
                                }
                                if isPM{
                                    Text("\(Int((detailsViewModel.weatherResponse?.current.vis_km)!)) km")
                                        .bold()
                                        .font(.title2)
                                        .padding(.bottom,60)
                                        .foregroundColor(.white)
                                }else{
                                    Text("\(Int((detailsViewModel.weatherResponse?.current.vis_km)!)) km")
                                        .bold()
                                        .font(.title2)
                                        .padding(.bottom,60)
                                }
                                
                                
                                if isPM{
                                    Text("FEELS LIKE")
                                        .padding(.bottom,5)
                                        .foregroundColor(.white)
                                }else{
                                    Text("FEELS LIKE")
                                        .padding(.bottom,5)
                                }
                                if isPM{
                                    Text("\(Int((detailsViewModel.weatherResponse?.current.feelslike_c)!))")
                                        .bold()
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }else{
                                    Text("\(Int((detailsViewModel.weatherResponse?.current.feelslike_c)!))")
                                        .bold()
                                        .font(.title2)
                                }
                                
                               
                                
                            }
                            Spacer()
                            VStack{
                                if isPM{
                                    Text("HUMIDITY")
                                        .padding(.bottom,5)
                                        .foregroundColor(.white)
                                }else{
                                    Text("HUMIDITY")
                                        .padding(.bottom,5)
                                }
                                if isPM{
                                    Text("\((detailsViewModel.weatherResponse?.current.humidity)!) %")
                                        .bold()
                                        .font(.title2)
                                        .padding(.bottom,60)
                                        .foregroundColor(.white)
                                }else{
                                    Text("\((detailsViewModel.weatherResponse?.current.humidity)!) %")
                                        .bold()
                                        .font(.title2)
                                        .padding(.bottom,60)
                                }
                                if isPM{
                                    Text("PRESSURE")
                                        .padding(.bottom,5)
                                        .foregroundColor(.white)
                                }else{
                                    Text("PRESSURE")
                                        .padding(.bottom,5)
                                }
                                if isPM{
                                    Text("\(Int((detailsViewModel.weatherResponse?.current.pressure_mb)!))")
                                        .bold()
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }else{
                                    Text("\(Int((detailsViewModel.weatherResponse?.current.pressure_mb)!))")
                                        .bold()
                                        .font(.title2)
                                }
                              
                            }
                        }.padding(.horizontal,50)
                    }
                }}
        }
    }
}
func getDayName(dayBeforeFormat:String)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dayBeforeFormat)
    let calendar = Calendar.current
    let weekday = calendar.component(.weekday, from: date!)
    let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    return dayNames[weekday - 1]
}
#Preview {
    DetailScreenView()
}

