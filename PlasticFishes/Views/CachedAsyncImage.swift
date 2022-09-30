//
//  CachedAsyncImage.swift
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 19/09/22.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {
    @ObservedObject var viewModel: CachedAsyncImageViewModel
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        _viewModel = ObservedObject(wrappedValue: CachedAsyncImageViewModel(url: url))
        self.content = content
    }

    var body: some View {
        content(viewModel.phase)
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(url: URL(string: "\(API.host)/blue.png")! ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
            default:
                fatalError()
            }
        }
    }
}
