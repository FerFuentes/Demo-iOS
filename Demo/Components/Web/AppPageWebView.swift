//
//  AppPageWebView.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI
import WebKit

struct AppPageWebView: View {
    var appPageStringURL: String?
    var headers: [String: String]?
    @State private var loading: Bool = false
    
    var body: some View {
        WebView(appPageStringUrl: appPageStringURL, headers: headers, loading: $loading)
            .overlay( loadingView, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder private var loadingView: some View {
        if loading {
            ZStack {
                ActivityIndicator(isAnimating: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.20)).edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView: UIViewRepresentable {
    var appPageStringUrl: String? =  ""
    let headers: [String: String]?
    @Binding var loading: Bool
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.loading = false
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.loading = true
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        
        let configuration = WKWebViewConfiguration()
        configuration.dataDetectorTypes = [.all]
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        
        Task {
            if let urlRequest = await createURLRequest() {
                webView.load(urlRequest)
            }
            loading = false
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No need to implement anything here
    }

    private func createURLRequest() async -> URLRequest? {
        loading = true

        // Safely unwrap and validate the URL
        guard let urlString = appPageStringUrl, let url = URL(string: urlString) else {
            print("Invalid or missing URL string: \(appPageStringUrl ?? "nil")")
            loading = false
            return nil
        }

        var request = URLRequest(url: url)

        // Safely unwrap and add headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }
    
}
