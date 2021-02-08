//
//  ViewController.swift
//  Yu-Gi-Oh-AR
//
//  Created by Jhoan Mauricio Vivas Rubiano on 8/02/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Images Successfully Added")
            
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
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "mago" {
                DispatchQueue.main.async {
                    if let magicianRingScene = SCNScene(named: "art.scnassets/magician_ring_cmt.scn") {
                        
                        
                        if let magicianRingNode = magicianRingScene.rootNode.childNodes.first {
                            
                            planeNode.addChildNode(magicianRingNode)
                        }
                    }
                    
                    if let darkMagicianScene = SCNScene(named: "art.scnassets/mago_oscuro.scn") {
                        
                        
                        if let darkMagicianRingNode = darkMagicianScene.rootNode.childNodes.first {
                            
                            darkMagicianRingNode.eulerAngles.x = .pi / 2
                            planeNode.addChildNode(darkMagicianRingNode)
                        }
                    }
                    
                }
            }
            
            if imageAnchor.referenceImage.name == "skull" {
                DispatchQueue.main.async {
                    if let magicianRingScene = SCNScene(named: "art.scnassets/magician_ring_cmt.scn") {
                        
                        if let magicianRingNode = magicianRingScene.rootNode.childNodes.first {
                            
                            planeNode.addChildNode(magicianRingNode)
                        }
                    }
                    
                    if let skullScene = SCNScene(named: "art.scnassets/summoned_skull.scn") {
                        
                        
                        if let skullNode = skullScene.rootNode.childNodes.first {
                            
                            planeNode.addChildNode(skullNode)
                        }
                    }
                    
                    
                }
            }
            
            
        }
        
        return node
        
    }
}
