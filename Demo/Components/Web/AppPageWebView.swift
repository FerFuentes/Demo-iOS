//
//  AppPageWebView.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI
import WebKit

struct AppPageWebView: View {
    var headers: [String: String]?
    @State var title: String
    @State var loading: Bool = false
    var url: URL?
    
    var body: some View {
        WebView(headers: headers, title: $title, loading: $loading, url: url)
            .overlay( loadingView, alignment: .center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(title)
    }
    
    @ViewBuilder private var loadingView: some View {
        if loading {
            ZStack {
                ActivityIndicatorView(isAnimating: $loading, color: .gray, style: .large)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.opacity(0.5)).edgesIgnoringSafeArea(.all)
        }
    }

}


struct WebView: UIViewRepresentable {
    let headers: [String: String]?
    @Binding var title: String
    @Binding var loading: Bool
    let url: URL?
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.loading = false
            
            webView.evaluateJavaScript("document.title") { (result, error) in
                if let title = result as? String {
                    DispatchQueue.main.async {
                        self.parent.title = title
                    }
                }
            }
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
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
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
        
        guard let requestURL = url else {
            return nil
        }
        
        var request = URLRequest(url: requestURL)
        
        // Safely unwrap and add headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
}
