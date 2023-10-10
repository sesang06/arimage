//
//  ViewController.swift
//  arimage
//
//  Created by sesang on 10/10/23.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            configuration.trackingImages = referenceImages
        }


        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/

    

    private func getMatchingUIImage(name: String) -> UIImage? {
        switch name {
        case "moving_castle":
            return #imageLiteral(resourceName: "moving_castle_image")
        case "cat_bus":
            return #imageLiteral(resourceName: "cat_bus_image")
        case "zelda":
            return #imageLiteral(resourceName: "zelda_image")
        default:
            return nil
        }
        return nil
    }


    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        guard let name = imageAnchor.referenceImage.name else {
            return
        }
        guard let image = self.getMatchingUIImage(name: name) else {
            return
        }
        DispatchQueue.main.async {

            let planeNode = self.generateNode(anchor: imageAnchor)
            node.addChildNode(planeNode)

            let textNode = self.generateNode(anchor: imageAnchor)
            self.createTextView(for: textNode)
            node.addChildNode(textNode)

        }
    }

    private func generateNode(anchor: ARImageAnchor) -> SCNNode {
        let plane = SCNPlane(width: anchor.referenceImage.physicalSize.width, height: anchor.referenceImage.physicalSize.height)


        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        return planeNode
    }

    func createTextView(for node: SCNNode) {

        let textViewController = UIHostingController(rootView: TextView())
        textViewController.willMove(toParent: self)
        
        self.addChild(textViewController)
        textViewController.view.frame = .init(x: 0, y: 0, width: 350, height: 200)
        self.view.addSubview(textViewController.view)

        let material = SCNMaterial()
        textViewController.view.isOpaque = false
        material.diffuse.contents = textViewController.view

        node.geometry?.materials = [material]

        textViewController.view.backgroundColor = .clear
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
