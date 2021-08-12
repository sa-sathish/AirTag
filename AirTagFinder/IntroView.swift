//
//  IntroView.swift
//  AirTagFinder
//
//  Created by sathish s on 11/08/2021.
//

import SwiftUI

struct IntroView: View {
    @State var isShow = false
    @State var onAppear = false
    var body: some View {
        ZStack{
            VStack{
                    Image("tag")
                        .resizable()
                        .frame(width: 290, height: 260, alignment: .center)
                        .padding(.bottom,50)
                        .offset(y:onAppear ? 10:-500)
                
                Text("Ping it. Find it.")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 30))
                    .padding(.all,5)
                    .offset(y:onAppear ? 0:100)

            
                Text("AirTag.")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .offset(y:onAppear ? 0:50)
                
                VStack{
                    Text("lose your knack for losing things")
                        .foregroundColor(.white)
                        .font(.system(size:18))
                        .fontWeight(.light)
                        .offset(y:onAppear ? 0:30)
                }
                .padding(.vertical,40)
                
                
                Button(action: {
                    withAnimation{
                        isShow.toggle()
                    }
                }, label: {
                    HStack{
                        Text("Get started")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                        Spacer()
                       Image(systemName: "arrow.right")
                        .foregroundColor(.black)
                    }
                    .frame(width:UIScreen.main.bounds.size.width/1.5)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
                })
                .offset(y:onAppear ? 0:200)
                
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.black )
//            .background(isShow ? Color.white : Color.black )
            .ignoresSafeArea()
            .onAppear{
                withAnimation(.spring(response: 0.7, dampingFraction: 0.7, blendDuration: 1.0)){
                    onAppear.toggle()
                }
            }
            if isShow {
                VStack{
                    Color.white
                }
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .ignoresSafeArea()
                HomeView(isPresented:$isShow)
            }
         
        }

    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
