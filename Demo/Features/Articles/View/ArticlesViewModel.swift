//
//  HouseViewModel.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import SwiftUI
import NetworkLibrary
import Combine

@MainActor
class ArticlesViewModel: ObservableObject, Core {
    
    @Published var loading = false
    @Published var articles: [Article] = []
    @Published var articleDetails: ArticleDetail?
    @Published var showAlertError: (show: Bool, requestError: RequestError?) = (show: false, requestError: nil)
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: ArticlesRepositoryImpl = {
        return ArticlesRepositoryImpl.shared
    }()
    
    init() {
        repository.loading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] show in
                guard let self = self else { return }
                self.loading = show
            }.store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    
    func validateLocationPermission() async {
        if isPermisionGranted {
            await fetchHouses()
        } else {
            locationPermissionStatus
                .receive(on: DispatchQueue.main)
                .sink { [weak self] status in
                    guard let self = self else { return }
                    
                    switch status {
                    case .always, .whenInUse:
                        Task {
                            await self.fetchHouses()
                        }
                    case .denied:
                        print(status)
                    case .notDetermined:
                        print("Ask for permissions")
                    }
                    
                }.store(in: &cancellables)
            requestPermission()
        }
    }
    
    func fetchHouses() async {
        do {
            let response = try await repository.fetchArticles()
            articles = response
        } catch let error as RequestError {
            showAlertError = (show: true, requestError: error)
        } catch {
            print(error)
        }
    }
    
    func fetchArticleDetails(id: String) async {
        do {
            let response = try await repository.fetchArticleDetails(id: id)
            articleDetails = ArticleDetail(
                id: id,
                name: response.name,
                imagesURL: [
                    "https://loremflickr.com/640/480/cats",
                    "https://loremflickr.com/640/480/cats",
                    "https://loremflickr.com/640/480/cats",
                    "https://loremflickr.com/640/480/cats",
                    "https://loremflickr.com/640/480/cats",
                    "https://loremflickr.com/640/480/cats",
                ],
                description: response.description)
        } catch let error as RequestError {
            showAlertError = (show: true, requestError: error)
        } catch {
            print(error)
        }
    }
    
}
