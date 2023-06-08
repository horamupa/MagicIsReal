//
//  BodyARView.swift
//  MagicIsReal
//
//  Created by MM on 07.06.2023.
//

import RealityKit

class BodyARView: ARView {
    
    /// This helps prevent memory leaks.
    func stopSession(){
           self.session.pause()
           self.scene.anchors.removeAll()
//           DataModel.shared.arView = nil
       }
}
