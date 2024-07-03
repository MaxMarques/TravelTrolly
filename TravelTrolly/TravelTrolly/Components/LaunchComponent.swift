//
//  LaunchComponent.swift
//  TravelTrolley
//
//  Created by Marques on 4/17/24.
//

import SwiftUI

struct LaunchComponent: View {
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    @EnvironmentObject var trolleyRoutesApi: TrolleyRoutesApi
    @EnvironmentObject var trolleyApi: TrolleyApi

    @State var isPresented: Bool = false
    @State var endAnimation: Bool = false
    @State var title1: String = "Travel Trolley"
    @State var title2: String = "Miami Beach"
    @State var index1: Double = 0.0
    @State var index2: Double = 0.0
    @State var char1: String = ""
    @State var char2: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background-1")
                
                VStack {
                    Image("logo-1")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                        .scaleEffect(isPresented ? 2 : 1)
                    
                    Text(char1)
                        .font(.custom("PlayFairDisplay-ExtraBold", size: UIScreen.main.bounds.width / 8))
                        .foregroundColor(Color("text-1"))
                        .bold()
                        .onAppear {
                            for number in title1 {
                                Timer
                                    .scheduledTimer(withTimeInterval: 0.1 * index1, repeats: false, block: {
                                        _ in self.char1.append(number)
                                    })
                                withAnimation {
                                    index1 += 1
                                }
                            }
                            
                        }
                        .padding(.top, 40)
                    
                    Text(char2)
                        .font(.custom("PlayFairDisplay-ExtraBold", size: UIScreen.main.bounds.width/11))
                        .foregroundColor(Color("text-2"))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12 * Double(title1.count)) {
                                for number in title2 {
                                    Timer
                                        .scheduledTimer(withTimeInterval: 0.1 * index2, repeats: false, block: {
                                            _ in self.char2.append(number)
                                        })
                                    withAnimation {
                                        index2 += 1
                                    }
                                }
                            }
                        }
                }.navigationDestination(isPresented: $endAnimation) {
                    MainView()
                        .navigationBarHidden(true)
                        .environmentObject(trolleyRoutesApi)
                        .environmentObject(trolleyApi)
                }
            }.ignoresSafeArea(.all, edges: .all)
                .onAppear(perform: animationSpalsh)
                .opacity(endAnimation ? 0 : 1)
        }
        .overlay(overlayView: ToastMessageModule.init(show: $trolleyRoutesApi.toastError, data: BannerDataModel(title: LocalizedStringKey("title0"), body: LocalizedStringKey("body0"), type: .error)), show: $trolleyRoutesApi.toastError)
        .overlay(overlayView: ToastMessageModule.init(show: $trolleyApi.toastError, data: BannerDataModel(title: LocalizedStringKey("title0"), body: LocalizedStringKey("body0"), type: .error)), show: $trolleyApi.toastError)
    }
    
    func animationSpalsh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.4) {
            withAnimation(Animation.easeOut(duration: 0.45)) {
                if (!trolleyRoutesApi.toastError && !trolleyApi.toastError) {
                    isPresented.toggle()
                }
            }
            
            withAnimation(Animation.easeOut(duration: 0.50)) {
                if (!trolleyRoutesApi.toastError && !trolleyApi.toastError) {
                    endAnimation.toggle()
                }
            }
        }
    }
}

#Preview() {
    LaunchComponent()
}
