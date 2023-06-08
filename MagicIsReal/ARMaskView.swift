//
//  ARViewSettings.swift
//  MagicIsReal
//
//  Created by MM on 07.06.2023.
//


import ARKit
import RealityKit
import BodyTracking
import SwiftUI
import CoreML

class ARMaskView: BodyARView {
    
    private var handTracker1: CustomHandTracker2D!
    var vm = MagicViewModel.shared

    // Track the screen dimensions:
    lazy var windowWidth: CGFloat = {
        return UIScreen.main.bounds.size.width
    }()
    
    lazy var windowHeight: CGFloat = {
        return UIScreen.main.bounds.size.height
    }()
    
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        
        self.handTracker1 = CustomHandTracker2D(arView: self)
//        CustomHandTracker2D(arView: self)
        self.handTracker1.jointScreenPositions.keys
//        self.handTracker2 = HandTracker2D(arView: self)
        
        makeHandJointsVisible(handTracker: handTracker1)
//        makeHandJointsVisible(handTracker: handTracker2)
    }
    
    lazy var mailLabel: UILabel = {
        var lb = UILabel()

//        let vm2 = MagicViewModel.shared

        lb.text = "🔥"
        lb.font = .systemFont(ofSize: 26, weight: .medium)
        lb.translatesAutoresizingMaskIntoConstraints =  false
        return lb
    }()
    
    lazy var coldLabel: UILabel = {
        var lb = UILabel()

//        let vm2 = MagicViewModel.shared

        lb.text = "❄️"
        lb.font = .systemFont(ofSize: 26, weight: .medium)
        lb.translatesAutoresizingMaskIntoConstraints =  false
        return lb
    }()
    
    ///This is an example for how to show multiple joints, iteratively.
    private func makeHandJointsVisible(handTracker: CustomHandTracker2D){
        
        //Another way to attach views to the skeletion, but iteratively this time:
        
        CustomHandTracker2D.allHandJoints.forEach { joint in
            if joint != CustomHandTracker2D.HandJointName.middleTip {
                let circle = makeCircle(circleRadius: 20, color: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1))
                //            let circle = makeSpell()
                handTracker.attach(thisView: circle, toThisJoint: joint)
            }
        }
            let spell = makeSpell()
        
//        vm.spell.spellUIView(frame: <#T##CGRect#>)
            handTracker.attach(thisView: spell, toThisJoint: CustomHandTracker2D.HandJointName.middleTip)
    }

    
    override func stopSession(){
        super.stopSession()
        self.handTracker1.destroy()
        self.handTracker1 = nil
//        self.handTracker2.destroy()
//        self.handTracker2 = nil
       }
    
    deinit {
        stopSession()
    }
    
    
    class ObservableFrameView: UIView {
        
        var frame2: CGRect = .zero {
            didSet {
                        // Do something whenever frame2 changes
                        print("Frame2 changed to: \(frame2)")
                MagicViewModel.shared.frame = frame2
                self.updateConstraints()
                    }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            // Update frame2 whenever the layout of the view changes
            
            frame2 = frame
        }
    }
    
    private func makeSpell() -> UIView {
        let frame = CGRect(x: windowWidth/2, y: windowWidth/2, width: 50, height: 50)
        let spellView = ObservableFrameView(frame: frame)
//        let subV = self.vm.spell.spellUIView(frame: frame)
        spellView.addSubview(mailLabel)
        
        mailLabel.translatesAutoresizingMaskIntoConstraints = false
        mailLabel.centerXAnchor.constraint(equalTo: spellView.centerXAnchor).isActive = true
        mailLabel.centerYAnchor.constraint(equalTo: spellView.centerYAnchor).isActive = true
        spellView.translatesAutoresizingMaskIntoConstraints =  false
//        spellView.layer.backgroundColor = #colorLiteral(red: 0.3175252703, green: 0.7384468404, blue: 0.9564777644, alpha: 1)
        return spellView
    }
    
    private func makeCircle(circleRadius: CGFloat = 72,
                            color: CGColor = #colorLiteral(red: 0.3175252703, green: 0.7384468404, blue: 0.9564777644, alpha: 1)) -> UIView {
        
        // Place circle at the center of the screen to start.
        let xStart = floor((windowWidth - circleRadius) / 2)
        let yStart = floor((windowHeight - circleRadius) / 2)
        let frame = CGRect(x: xStart, y: yStart, width: circleRadius, height: circleRadius)
        
        let circleView = UIView(frame: frame)
        circleView.layer.cornerRadius = circleRadius / 2
        circleView.layer.backgroundColor = color
        return circleView
    }
    
    
//    required function.
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
   
}



