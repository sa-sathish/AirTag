//
//  TabView.swift
//  AirTagFinder
//
//  Created by sathish s on 11/08/2021.
//

import SwiftUI


var tabbarItems = ["house","ticket","bolt","person"]

struct CustomTabView : View {
    @State var selectedTab = "house"
    @Namespace var animation
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    var body: some View{

        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            
            if selectedTab == "house" {
                TabbarView(pageName:"home")
                
            }else if selectedTab == "ticket" {
                TabbarView(pageName:"1")
            }
            else if selectedTab == "bolt" {
                TabbarView(pageName:"2")
            }
            else if selectedTab == "person" {
                TabbarView(pageName:"4")
            }
            VStack{
                
                HStack(spacing:0){
                    ForEach(tabbarItems,id: \.self){ image in
                        TabbarButtons(image:image, animation:animation, selectedTab: $selectedTab)
                        if image != tabbarItems.last{
                            Spacer(minLength: 0)
                        }

                    }
                }
                .padding(.all,5)
                .background(Color.white)
                .padding(.bottom,edge?.bottom)
                .shadow(radius: 5)
                
//                    .border(Color.red, width: 4)
                
                
            }
           
        }
        // ignore keyboard elevation
        .ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct TabbarView : View {
    var pageName: String
    var body: some View{
        VStack{
            Text(pageName)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
    }
}




struct TabbarButtons : View {
    var image : String
    var animation : Namespace.ID
    @Binding var selectedTab : String
    var body: some View{
        Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)){
                    selectedTab = image
                    }
                 }, label: {
            Image(systemName: image)
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .foregroundColor(selectedTab == image ? Color.white : Color.gray)
                .padding()
                .background(
                    ZStack{
                    if selectedTab == image {
                        Color.black
                          .clipShape(Circle())
                            .matchedGeometryEffect(id: "tabbar", in: animation)
                    }
                    }
                )
        })
    }
}
