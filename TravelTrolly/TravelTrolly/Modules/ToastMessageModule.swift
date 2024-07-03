//
//  ToastMessageModule.swift
//  TravelTrolley
//
//  Created by Marques on 4/23/24.
//

import SwiftUI

struct BannerDataModel {

    var title: LocalizedStringKey
    var body: LocalizedStringKey
    var type: BannerType
}

enum BannerType {

    case info
    case warning
    case success
    case error
    
    var toastColor: Color {

        switch self {
        case .info:
            return .blue
        case .success:
            return .green
        case .warning:
            return .yellow
        case .error:
            return .red
        }
    }
 
    var toastSymbol: String {
     
        switch self {
        case .info:
            return "info.circle"
        case .success:
            return "checkmark.seal"
        case .warning:
            return "exclamationmark.octagon"
        case .error:
            return "xmark.octagon"
        }
    }
}

struct ToastMessageModule: View {

    @Binding var show: Bool
    let data: BannerDataModel
    
    @State var rotation: CGFloat = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Image.init(systemName: data.type.toastSymbol)

                VStack(alignment: .leading, spacing: 2) {
                    Text(data.title)
                        .bold()

                    Text(data.body)
                        .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                }

                Spacer()
            }
            .foregroundColor(Color("text-3"))
            .padding(12)
            .background(data.type.toastColor)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
            withAnimation(Animation.easeInOut) {
                self.show = false
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation(Animation.easeInOut) {
                    self.show = false
                }
            }
        })
    }
}

struct Overlay<T: View>: ViewModifier {
    
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content

            if show {
                overlayView
            }
        }
    }
}

extension View {

    func overlay<T: View>( overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay.init(show: show, overlayView: overlayView))
    }
}


#Preview {
    ToastMessageModule(show: .constant(true), data: BannerDataModel(title: "", body: "", type: .success))
}

