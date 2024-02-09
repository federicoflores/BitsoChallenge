//
//  ErrorView.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import SwiftUI

struct ErrorView: View {
    
    var action: (()->())?
    var subtitle: String?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                mainImage
                titleText
                subtitleText
                retryButton
                Spacer()
            }
        }
    }
    
    private var mainImage: some View {
        Image("error")
            .resizable()
            .frame(width: 200, height: 200)
            .padding(.top ,60)
    }
    
    private var titleText: some View {
        Text("There's been a problem")
            .font(.title).bold()
            .multilineTextAlignment(.center)
            .padding(12)
            .foregroundColor(.white)
    }
    
    private var subtitleText: some View {
        Text(subtitle ?? "")
            .padding(.bottom, 70)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray).opacity(0.7)
    }
    
    private var retryButton: some View {
        Button("Try again") {
            action?()
        }
        .frame(width: 140, height: 50)
        .background(.blue)
        .foregroundColor(.white)
        .cornerRadius(15)
        .font(.title)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(action: nil, subtitle: "There seems to be a connection problem")
    }
}
