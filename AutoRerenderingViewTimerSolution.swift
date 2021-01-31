//
//  AutoRerenderingView.swift
//  appmaker
//
//  Created by Joseph Hinkle on 12/28/20.
//

import SwiftUI

struct AutoRerenderingView<Content: View, LoadContent: View, Hash: Hashable>: View {
    private let build: () -> Content
    private let loadView: LoadContent
    private let hash: Hash
    
    @State private var contentToShowHash: Hash? = nil
    @State private var count = 0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    
    public init(_ build: @autoclosure @escaping () -> Content, loadView: LoadContent, hash: Hash) {
        self.build = build
        self.loadView = loadView
        self.hash = hash
    }
    
    public init(_ build: @autoclosure @escaping () -> Content, hash: Hash) where LoadContent == ProgressView<EmptyView, EmptyView> {
        self.build = build
        self.loadView = ProgressView()
        self.hash = hash
    }
    
    public var body: some View {
        Group {
            if contentToShowHash == hash {
                build()
            } else {
                loadView
            }
        }.onReceive(timer) { _ in
            if contentToShowHash != hash {
                count += 1
                if count >= 2 {
                    contentToShowHash = hash
                    count = 0
                }
            }
        }
    }
}
