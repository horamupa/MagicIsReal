//
//  MagicView.swift
//  MagicIsReal
//
//  Created by MM on 07.06.2023.
//

import SwiftUI
import RealityKit
import ARKit
import BodyTracking
import CoreML

enum Effects {
    
    static var shared = Effects.none
    
    case fire
    case cold
    case wind
    case earth
    case pick
    case none
    
    func chooseSpell(spell: Effects) {
//        self.
    }
    
    enum handGesture {
        case one
        case action
        case casted
    }
    
    var emoji: String {
        switch self {
            case .fire:
                return "🔥"
            case .cold:
                return "❄️"
            case .wind:
                return "🌬"
            case .earth:
                return "💎"
            case .pick:
                return "❗️"
            case .none:
                return ""
        }
    }
    
    func spellUIView(frame: CGRect) -> UIView {
        let spellView = UIView(frame: frame)
        let SUIContainer = UIHostingController(rootView: spellSUI())
        spellView.addSubview(SUIContainer.view)
        return spellView
    }
}

class MagicViewModel: ObservableObject {
    static var shared = MagicViewModel()
    @Published var spell: Effects = .none
    @Published var frame: CGRect = .zero
    
    
}

struct MagicView: View {
    
    @StateObject var vm = MagicViewModel.shared

    var body: some View {
        ZStack {
            ARViewContainer()
            Text("\(vm.spell.emoji)")
            Text("\(vm.frame.midX)")
                .font(.title)
                .offset(x: vm.frame.midX, y: vm.frame.midY)
        }
    }
}

struct MagicView_Previews: PreviewProvider {
    static var previews: some View {
        MagicView()
    }
}

struct ARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {
        return ARMaskView(frame: .zero)
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct spellPositionPrefKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize()
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct spellSUI: View {
    
    var vm = MagicViewModel.shared
    var body: some View {
        Text(vm.spell.emoji)
    }
}
