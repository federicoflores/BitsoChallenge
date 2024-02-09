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
        case .error(let error):
            ErrorView(action: retrieveData, subtitle: error)
        case .success:
            successView
        }
    }
    
    private func retrieveData() {
        viewModel.retrieveArtoworkDetail(id: viewModel.id)
        viewModel.artworkDetailState = .loading
    }
    
    fileprivate var successView: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    title
                    subtitle
                    if let UIImage = viewModel.image {
                        image(UIImage: UIImage)
                    }
                    artistDisplay
                    
                    ArtworkDetailDataRow(keyText: "Date: ", content: Text(viewModel.artwork?.result.dateDisplay ?? ""))
                    
                    ArtworkDetailDataRow(keyText: "Place of origin: ", content: Text(viewModel.artwork?.result.placeOfOrigin ?? ""))
                    
                    ArtworkDetailDataRow(keyText: "Dimensions: ", content: Text(viewModel.artwork?.result.dimensions ?? ""))
                    
                    ArtworkDetailDataRow(keyText: "", content: Text(viewModel.artwork?.result.provenanceText ?? ""))
                        .foregroundColor(.gray).opacity(0.7)
                }
            }
        }
    }
    
    fileprivate var loadingView: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ProgressView()
                .controlSize(.extraLarge)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
        }
    }
    
    fileprivate var title: some View {
        Text(viewModel.artwork?.result.title ?? "")
            .foregroundColor(.white)
            .padding(.top, 20)
            .padding(.bottom, 2)
            .multilineTextAlignment(.center)
            .font(.largeTitle).bold()
    }
    
    fileprivate var subtitle: some View {
        Text(viewModel.artwork?.result.mediumDisplay ?? "")
            .foregroundColor(.white)
    }
    
    fileprivate var artistDisplay: some View {
        Text(viewModel.artwork?.result.artistDisplay ?? "")
            .foregroundColor(.gray)
            .padding(.bottom, 20)
            .multilineTextAlignment(.center)
            .font(.headline)
    }
    
    fileprivate func image(UIImage: UIImage) -> some View {
        Image(uiImage: UIImage)
            .resizable()
            .colorMultiply(.white)
            .frame(width: 300, height: 300)
    }
}

fileprivate struct ArtworkDetailDataRow<Content: View>: View
{
    
    let keyText: String
    let content: Content
    
    var body: some View {
        HStack {
            if keyText != "" {
                Text(keyText)
            }
            content
            Spacer()
        }
        .foregroundColor(.white)
        .padding(10)
    }
    
}

#Preview {
    ArtworkDetailView(viewModel: ArtworkDetailViewModel(provider: NetworkProvider(), id: 20314))
}
