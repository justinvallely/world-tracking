//
//  ViewController.swift
//  World Tracking
//
//  Created by Justin Vallely on 6/21/18.
//  Copyright © 2018 Pajama Donkey. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

//        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//        // Set the scene to the view
//        sceneView.scene = scene
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    @IBAction func addButtonAction(_ sender: Any) {

        let pyramidNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        pyramidNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        pyramidNode.position = SCNVector3(0, 0, -0.3)

        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cubeNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        cubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        cubeNode.position = SCNVector3(0, -0.05, 0)

        let planeNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        planeNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        planeNode.position = SCNVector3(0, -0.02, 0.053)

        sceneView.scene.rootNode.addChildNode(pyramidNode)
        pyramidNode.addChildNode(cubeNode)
        cubeNode.addChildNode(planeNode)
    }

    @IBAction func resetButtonAction(_ sender: Any) {
        restartSession()
    }

    private func restartSession() {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }

        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    private func randonNumbers(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
}

// MARK: - ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {

}
