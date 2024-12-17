//
//  AsyncImageLoader.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import Foundation
import SwiftUI

@MainActor
class AsyncImageLoader: ObservableObject {
    enum LoadingState {
        case loading
        case success(Image)
        case failure(Error)
    }

    enum ImageLoaderError: Error {
        case invalidData
        case networkError(Error)
    }

    @Published var state: LoadingState = .loading
    private var retryCount = 0
    private let maxRetryCount = 3
    private var currentURL: URL?
    private var scale: CGFloat?

    func loadImage(from url: URL, scale: CGFloat? = nil) {
        state = .loading
        currentURL = url
        self.scale = scale
        Task {
            await fetchImage(from: url)
        }
    }

    private func fetchImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data, scale: scale ?? 1.0) else {
                throw ImageLoaderError.invalidData
            }
            self.state = .success(Image(uiImage: uiImage))
        } catch {
            self.state = .failure(ImageLoaderError.networkError(error))
        }
    }

    func retryLoadImage(after delay: TimeInterval = 2) {
        guard retryCount < maxRetryCount, let currentURL = currentURL else { return }
        retryCount += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.loadImage(from: currentURL, scale: self?.scale)
        }
    }
}
