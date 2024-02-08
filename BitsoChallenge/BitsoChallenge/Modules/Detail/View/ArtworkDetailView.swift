//
//  ArtworkDetailView.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 07/02/2024.
//

import SwiftUI

struct ArtworkDetailView: View {
    
    @ObservedObject var viewModel: ArtworkDetailViewModel
    
    var body: some View {
        switch viewModel.artworkDetailState {
        case .loading:
            loadingView
        case .error:
            SwiftUIErrorView(action: retrieveData)
        case .success:
            successView
        }
    }
    
    private func retrieveData() {
        viewModel.retrieveData(id: viewModel.id)
    }
    
    fileprivate var successView: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
        ScrollView {
                VStack {
                    Text(viewModel.artwork?.result.title ?? "")
                        .foregroundColor(.white)
                        .padding(20)
                        .multilineTextAlignment(.center)
                        .font(.title).bold()
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .colorMultiply(.white)
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                    Text(viewModel.artwork?.result.artistDisplay ?? "")
                        .foregroundColor(.gray)
                        .padding(20)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                    HStack {
                        Text("Date display: ")
                        Text(viewModel.artwork?.result.dateDisplay ?? "")
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    HStack {
                        Text("Place of origin: ")
                        Text(viewModel.artwork?.result.placeOfOrigin ?? "")
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    HStack {
                        Text("Dimensions: ")
                        Text(viewModel.artwork?.result.dimensions ?? "")
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    HStack {
                        Text("Medium display: ")
                        Text(viewModel.artwork?.result.mediumDisplay ?? "")
                    }
                    .foregroundColor(.white)
                    .padding(10)
                    Text(viewModel.artwork?.result.provenanceText ?? "")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    fileprivate var loadingView: some View {
        ZStack {
            Color.black
            ProgressView()
                .controlSize(.extraLarge)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
        }
    }
    
}

#Preview {
    ArtworkDetailView(viewModel: ArtworkDetailViewModel(provider: NetworkProvider(), id: 20314))
}
