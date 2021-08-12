//
//  HomeView.swift
//  AirTagFinder
//
//  Created by sathish s on 11/08/2021.
//

import SwiftUI

struct HomeView: View {
    @State var isApear = false
    @Namespace var animation
    @State var isShow = false
    @Binding var isPresented : Bool
    @State var selectedObj = Devices(title: "", image: "", distanceByCar: "", distanceByWalk: "", battery: "", sqft: "")
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                
                HStack{
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title)
                    })
                    .frame(width: 55, height: 55)
                    Spacer()
                    Text("Devices ")
                        .font(.system(size: 25))
                        .fontWeight(.heavy)
                    +
                        Text("\(DataSource.count)")
                            .font(.system(size: 25))
                            .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top,30)
               
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing:25){
                        ForEach(DataSource, id: \.id){ item in
                            DeviceView(object: item, isPresented: $isShow, selected: $selectedObj)
                                .scaleEffect(isApear ? 1 : 0)
                                .offset(y: isApear ? 0 : -300)
                                .onTapGesture {
                                    withAnimation{
                                        isShow.toggle()
                                        selectedObj = item
                                    }
                                   
                                }
                           }
                    }
                    
                }
            }
            
            .padding()
            .background(Color.gray.opacity(0.1))
            .onAppear() {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1.0)){
                        self.isApear = true
                    }
            }

            if isShow {
                MapView(object: self.selectedObj, isPresent: $isShow)
            }
        }
        .ignoresSafeArea()
            
            
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}



struct BrowseView : View {
    var body: some View{
        VStack{
            Text("sathish")
        }
    }
}

struct DeviceView : View {
    let object : Devices
    @Binding var isPresented: Bool
    @Binding var selected: Devices
    var body: some View{
        VStack(alignment: .leading,spacing:16){
            HStack{
                VStack(alignment: .leading){
                    Text(object.title)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    HStack{
                        HStack{
                            Image(systemName: "car")
                            Text(object.distanceByCar)
                                .font(.footnote)

                        }
                        HStack{
                            Image(systemName: "figure.walk")
                            Text(object.distanceByWalk)
                                .font(.footnote)
                                
                        }
                        HStack{
                            Image(systemName: "battery.25")
                            Text(object.battery)
                                .font(.footnote)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
               
                    Image(object.image)
                        .resizable()
                        .frame(width: 70, height: 70, alignment: .center)
                        
            }
            
            
            HStack{
                Button(action: {
                    
                }, label: {
                    HStack{
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.accentColor)
                        Text("Play sound")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            
                            
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8.0)
                })
                Spacer()
                Button(action: {
                    selected = object
                }, label: {
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.green)
                        Text(object.sqft)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8.0)
                })
                
            }
 
        }.padding()
        .background(Color.white)
        .cornerRadius(20.0)
//        .navigate(to: MapView(object: self.object), when: $isShow)
    }
}

struct Devices:Identifiable {
    var id = UUID().uuidString
    var title:String
    var image:String
    var distanceByCar:String
    var distanceByWalk:String
    var battery:String
    var sqft:String
}

// MARK:-> Mock data



let DataSource = [
    Devices(title: "AirPods Max", image: "1", distanceByCar: "13 min", distanceByWalk: "30 min", battery: "67 %", sqft: "934.6 ft"),
    
    Devices(title: "Backpack", image: "2", distanceByCar: "16 min", distanceByWalk: "30 min", battery: "98 %", sqft: "934.6 ft"),
    
    Devices(title: "Trolly", image: "3", distanceByCar: "34 min", distanceByWalk: "30 min", battery: "23 %", sqft: "934.6 ft"),
    
    Devices(title: "Jake’s scooter", image: "4", distanceByCar: "64 min", distanceByWalk: "30 min", battery: "10 %", sqft: "934.6 ft"),
    
    Devices(title: "Call Taxi", image: "5", distanceByCar: "10 min", distanceByWalk: "30 min", battery: "75 %", sqft: "934.6 ft"),
    
    Devices(title: "Auto", image: "6", distanceByCar: "13 min", distanceByWalk: "30 min", battery: "56 %", sqft: "934.6 ft"),
    
    Devices(title: "Bus", image: "7", distanceByCar: "13 min", distanceByWalk: "30 min", battery: "23 %", sqft: "934.6 ft"),
    
    Devices(title: "Hand bag", image: "8", distanceByCar: "13 min", distanceByWalk: "10 min", battery: "47 %", sqft: "934.6 ft"),
    
]
