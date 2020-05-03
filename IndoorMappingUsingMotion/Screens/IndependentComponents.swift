//
//  independentUI.swift
//  InterDevicePointer
//
//  Created by sachin jeph on 28/04/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct CustomBlur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}


struct bgDepthEffect: ViewModifier {
    var color : Color = Color.init("DefaultBGColor")
   
    func body(content: Content) -> some View {
        content
            .padding()
            .background(self.color)
           
                       .cornerRadius(10)
                       .shadow(color: Color.secondary.opacity(0.1), radius: 2)
                       .shadow(color: Color.primary.opacity(0.2), radius: 2)
            
            .padding()
    }
}


func UIScreenHeader(title : String)->some View{
    return HStack{
        Text(title)
            .fontWeight(.heavy)
            .font(.largeTitle)
        
        Spacer()
    }.padding(.leading)
    
}

func label(imgName : String,title:String,content :String,units : String,small : Bool = false)->some View{
    return VStack(alignment:.leading){
        VStack(alignment:.leading){
        HStack{
            Image(systemName : imgName)
            
            Text(title)
                .fontWeight(.bold)
                .font(.headline)
           
            Spacer()
        }.padding(.top,5)
        .foregroundColor(.orange)
        
        HStack{
           Text(content)
            .fontWeight(.bold)
            .font(small ? .headline : .title)
        
        
        
        Text(units)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.leading,5)
        }.padding(.vertical,10)
        }
        .padding(.vertical,5)
        .padding(.horizontal)
        .background(CustomBlur(style: .systemUltraThinMaterial))
        .cornerRadius(10)
    }
}
