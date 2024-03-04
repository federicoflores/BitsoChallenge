//
//  ArtworkDetailView.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 07/02/2024.
//

import SwiftUI

struct ArtworkDetailView: View {
    
    fileprivate enum Constant {
        static let backgroundColorOpacity: CGFloat = 0.9
        static let dateInfoKey: String = "Date: "
        static let placeOfOriginInfoKey: String = "Place of origin: "
        static let dimensionInfoKey: String = "Dimensions: "
        static let titleTopPadding: CGFloat = 20
        static let titleBottomPadding: CGFloat = 2
        static let artistDisplayBottomPadding: CGFloat = 20
        static let imageSize: CGFloat = 200
        static let infoTextForegroundColorOpacity: CGFloat = 0.7
    }
    
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
            Color.black.opacity(Constant.backgroundColorOpacity)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    title
                    subtitle
                    if let UIImage = viewModel.image {
                        image(UIImage: UIImage)
                    }
                    artistDisplay
                    
                    ArtworkDetailInfoView(keyText: Constant.dateInfoKey, content: Text(viewModel.artwork?.result.dateDisplay ?? ""))
                    
                    ArtworkDetailInfoView(keyText: Constant.placeOfOriginInfoKey, content: Text(viewModel.artwork?.result.placeOfOrigin ?? ""))
                    
                    ArtworkDetailInfoView(keyText: Constant.dimensionInfoKey, content: Text(viewModel.artwork?.result.dimensions ?? ""))
                    
                    ArtworkDetailInfoView(keyText: "", content: Text(viewModel.artwork?.result.provenanceText ?? ""))
                        .foregroundColor(.gray).opacity(Constant.infoTextForegroundColorOpacity)
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
            .padding(.top, Constant.titleTopPadding)
            .padding(.bottom, Constant.titleBottomPadding)
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
            .padding(.bottom, Constant.artistDisplayBottomPadding)
            .multilineTextAlignment(.center)
            .font(.headline)
    }
    
    fileprivate func image(UIImage: UIImage) -> some View {
        Image(uiImage: UIImage)
            .resizable()
            .colorMultiply(.white)
            .frame(width: Constant.imageSize, height: Constant.imageSize)
    }
}

fileprivate struct ArtworkDetailInfoView<Content: View>: View
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
