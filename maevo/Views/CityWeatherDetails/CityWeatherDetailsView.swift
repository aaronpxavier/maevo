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
    @State private var dragAmount = CGSize.zero
    let mf = MeasurementFormatter()
    
    init(cityId: String) {
        self.cityId = cityId
        mf.numberFormatter.maximumFractionDigits = 0
    }
    
    var body: some View {
    
        
        ZStack {
            HStack {
                if(cityWxDetailsViewModel.isLoading) {
                    VStack {
                        ProgressView()
                            .scaleEffect(CGFloat(5.0), anchor: .center)
                            .progressViewStyle(CircularProgressViewStyle(tint: .pink))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    
                }
                if let wx = cityWxDetailsViewModel.wx {
                    Spacer()
                    VStack {
                        if let wxIconSysName = cityWxDetailsViewModel.wx?.weather.first?.icon.fetchSysImgName(), !cityWxDetailsViewModel.isLoading {
                            Image(systemName: wxIconSysName)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color("wx_details_text"))
                                .frame(maxWidth: UIScreen.main.bounds.width * 0.25)
                        }
                        if let temp = cityWxDetailsViewModel.temp {
                            Text(mf.string(from: temp))
                                .fontWeight(.heavy)
                                .font(.system(size: 35))
                                .foregroundColor(Color("wx_details_text"))
                        }
                        
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
            
            
            
            
        }.background {
            ZStack {
     
                Image("details_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    
   
                if(dragAmount.height > 50) {
                    VStack {
                        if(dragAmount.height <= 150) {
                            Image(systemName: "arrow.down.to.line")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                                .padding(.bottom, 10)
                        }
                        
                        if(dragAmount.height > 150) {
                            Image(systemName: "arrow.clockwise")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(minWidth: 0, maxWidth: 50, minHeight: 0, maxHeight: 50)
                        }
                        
                                                
                        
                    }
                    .padding(.bottom, 30)
                    .offset(CGSize(width: 0, height: -400))
                    
                }
            }
            
        }.offset(dragAmount)
    
            .animation(.linear.speed(dragAmount.height > 0 && !cityWxDetailsViewModel.isLoading ? 2 : 0.5), value: dragAmount)
        
        .navigationTitle(cityWxDetailsViewModel.isLoading ? "Loading ..." : "\(cityWxDetailsViewModel.city), \(cityWxDetailsViewModel.state)")
        .gesture(
            DragGesture()
                .onChanged {
                    let timeSinceLastRun = Date().timeIntervalSince1970.magnitude - cityWxDetailsViewModel.gestureAnimationStartTime.timeIntervalSince1970.magnitude
                    if(!cityWxDetailsViewModel.isLoading && timeSinceLastRun > 1) {
                        let widthChange = 0
                        let heightChange = $0.translation.height > 50 && $0.translation.height < 250 ? $0.translation.height : 0
                        dragAmount = CGSize(width: widthChange, height: Int(heightChange))
                        if dragAmount.height > 150 {
                            cityWxDetailsViewModel.isLoading = true
                            cityWxDetailsViewModel.fetchCityDetailsWithId(cityId)
                            cityWxDetailsViewModel.gestureAnimationStartTime = Date()
                        }
                    } else if timeSinceLastRun > 0.25 {
                        dragAmount = CGSize(width: 0, height: 0)
                    }
                   
                }
            .onEnded { _ in dragAmount = .zero}
        )
      
        
        
    }
        
}
        
