//
//  AutoRerenderingView.swift
//  appmaker
//
//  Created by Joseph Hinkle on 12/28/20.
//

import SwiftUI

struct AutoRerenderingView<Content: View, Hash: Hashable>: View {
    private let build: () -> Content
    private let hash: Hash
    
    @State private var contentToShowHash: Hash? = nil
    
    public init(_ build: @autoclosure @escaping () -> Content, hash: Hash) {
        self.build = build
        self.hash = hash
    }
    
    public var body: some View {
        if contentToShowHash == hash {
            build()
        } else {
            ProgressView().animation(nil).onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                    withAnimation(.linear(duration: 0)) {
                        contentToShowHash = hash
                    }
                }
            }
        }
    }
}
