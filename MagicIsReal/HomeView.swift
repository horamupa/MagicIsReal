//
//  ContentView.swift
//  MagicIsReal
//
//  Created by MM on 07.06.2023.
//

import SwiftUI
import RealityKit
import CoreML
import ARKit

struct HomeView: View {
//    @EnvironmentObject var data: DataModel
    var body: some View {
        ZStack {
            Router.arView
                .ignoresSafeArea()
//            ARViewContainer.shared.edgesIgnoringSafeArea(.all)
        }  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


