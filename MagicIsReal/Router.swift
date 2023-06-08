//
//  Model.swift


import Combine
import RealityKit
import SwiftUI
import ARKit
import BodyTracking
import CoreML

enum Router {
    
    case arView
    case settings
    case deepLink
}

extension Router: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Router, rhs: Router) -> Bool {
        switch(lhs, rhs) {
            case (.deepLink, .deepLink):
                return true
            default:
                return false
        }
    }
}

extension Router: View {
//    static var shared = DataModel()
    var body: some View {
        switch self {
        case .arView:
            MagicView()
        case .settings:
            EmptyView()
        case .deepLink:
            EmptyView()
        }
    }
}


