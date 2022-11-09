//
//  CityWeatherDetailsView.swift
//  maevo
//
//  Created by Aaron Xavier on 10/30/22.
//

import SwiftUI
import Charts



struct CityWeatherDetailsView: View {
    let cityId: String
    @StateObject var cityWxDetailsViewModel: CityWeatherDetailsViewModel = CityWeatherDetailsViewModel()

    init(cityId: String) {
        self.cityId = cityId
    }
    var body: some View {
        HStack {
            Spacer()
            if let wx = cityWxDetailsViewModel.wx {
                VStack {
                    //AsyncImage(url: cityWxDetailsViewModel.wxIconURL)
                    if let wxIconSysName = cityWxDetailsViewModel.wx?.weather.first?.icon.fetchSysImgName() {
                        Image(systemName: wxIconSysName)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("wx_details_text"))
                            .frame(maxWidth: 150)
                    }

                    Text("\(Int(wx.main.temp)) ℃")
                        .fontWeight(.heavy)
                        .font(.system(size: 35))
                        .foregroundColor(Color("wx_details_text"))
                    Text("\(wx.weather.first?.description ?? "")")
                        .fontWeight(.heavy)
                        .font(.system(size: 20))
                        .foregroundColor(Color("wx_details_text"))
                    Spacer()
                }.padding(.trailing, 10)
            }
        }
        .onAppear() {
            cityWxDetailsViewModel.fetchCityDetailsWithId(cityId)
        }
        .navigationTitle("\(cityWxDetailsViewModel.city), \(cityWxDetailsViewModel.state)")
    }
        
}
        
//        GeometryReader { geom in
//            ZStack {
//                Image("details_background")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//                    if let wx = cityWxDetailsViewModel.wx {
//                        HStack(alignment: .top, spacing: 0) {
//                            Spacer()
//                            VStack{
//                                    //AsyncImage(url: cityWxDetailsViewModel.wxIconURL)
//                                    if let wxIconSysName = cityWxDetailsViewModel.wx?.weather.first?.icon.fetchSysImgName() {
//                                        Image(systemName: wxIconSysName)
//
//                                            .resizable()
//                                            .scaledToFit()
//                                            .foregroundColor(Color("wx_details_text"))
//                                            .frame(maxWidth: 150)
//                                    }
//
//                                    Text("\(Int(wx.main.temp)) ℃")
//                                        .fontWeight(.heavy)
//                                        .font(.system(size: 35))
//                                        .foregroundColor(Color("wx_details_text"))
//                                    Text("\(wx.weather.first?.description ?? "")")
//                                        .fontWeight(.heavy)
//                                        .font(.system(size: 20))
//                                        .foregroundColor(Color("wx_details_text"))
//                                Spacer()
//                                }
//
//                            }
//
//                    }
//
//            }
//
//        }
//
//
//
//        .onAppear() {
//            cityWxDetailsViewModel.fetchCityDetailsWithId(cityId)
//        }
//        .navigationTitle("\(cityWxDetailsViewModel.city), \(cityWxDetailsViewModel.state)")
//    }
//}
//




