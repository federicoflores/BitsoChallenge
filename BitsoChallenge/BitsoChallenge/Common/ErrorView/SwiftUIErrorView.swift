//
//  ErrorView.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import SwiftUI

struct SwiftUIErrorView: View {
    
    var action: (()->())?
    
    var body: some View {
        ZStack {
            VStack {
                Image("sad-face")
                    .resizable()
                    .foregroundColor(.white)
                    .background(.black)
                    .frame(width: 250, height: 250)
                    .cornerRadius(25)
                Text("There's been a problem")
                    .font(.title)
                    .padding(12)
                    .foregroundColor(.white)
                Button("Try again") {
                    action?()
                }
                .border(.blue)
                .frame(width: 100, height: 50)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(15)
                .font(.headline)
                Spacer()
            }
            .padding(.top, 75)
            .frame(maxWidth: .infinity)
            .background(.black)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIErrorView(action: nil)
    }
}
