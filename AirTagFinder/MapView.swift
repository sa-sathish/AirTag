//
//  MapView.swift
//  AirTagFinder
//
//  Created by sathish s on 12/08/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 10.7870, longitude: 79.1378), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
     var pointsOfInterest = [
        AnnotatedItem(name: "Times Square", coordinate: .init(latitude: 10.7870, longitude: 79.1378))
        ]
    var object : Devices
    @Binding var isPresent : Bool
    @State var bottomSheetShown = true
   
    var body: some View {
        GeometryReader { geometry in
        ZStack(alignment:.topLeading){
                Map(coordinateRegion: $region, annotationItems: pointsOfInterest) { item in
                    MapMarker(coordinate: item.coordinate, tint: .green)
                }
           
            
            HStack{
                Button(action: {
                    isPresent.toggle()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title)
                })
                .frame(width: 55, height: 55)
            }
            .padding()
            .padding(.top,20)
            
            BottomSheetView(
                           isOpen: self.$bottomSheetShown,
                           maxHeight: geometry.size.height * 0.4
                       ) {
                VStack{
                    Image(object.image)
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text(object.title)
                        .fontWeight(.heavy)
                        .font(.system(size: 25))
                        .padding()
                    Button(action: {}, label: {
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

                }
                
                .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(Color.white)

                       }
            
        }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}
struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}
