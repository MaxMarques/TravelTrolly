//
//  carouselSelectorComponent.swift
//  TravelTrolley
//
//  Created by Marques on 4/26/24.
//

import SwiftUI

struct carouselSelectorComponent: View {
    
    @EnvironmentObject var locationManager: LocationManager

    @State private var currentIndex: Int = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(Color("background-2").opacity(0.95))
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.width / 5)
            
            ForEach(0..<locationManager.routeName.count, id: \.self) { index in
                Text(locationManager.routeName[index])
                    .foregroundColor(Color("text-3"))
                    .bold()
                    .scaleEffect(currentIndex == index ? UIScreen.main.bounds.width / 280 : 0.8)
                    .offset(x: CGFloat(index - currentIndex) * 200, y: 0)
                    .frame(width: UIScreen.main.bounds.width / 1.7, height: UIScreen.main.bounds.width / 6)
                    .clipped()
            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(locationManager.routeName.count - 1, currentIndex + 1)
                            }
                        }
                    })
            )
            VStack {
                Text(LocalizedStringKey("subtitle0"))
                    .foregroundColor(Color("text-3"))
                    .font(.system(size: UIScreen.main.bounds.width / 30))
                    .padding(.top, UIScreen.main.bounds.width / 7)
            }
        }.onChange(of: currentIndex, initial: true) { _ , index in
            locationManager.trolleyRoutes = locationManager.routeName[index]
        }
    }
}

#Preview {
    carouselSelectorComponent()
}
