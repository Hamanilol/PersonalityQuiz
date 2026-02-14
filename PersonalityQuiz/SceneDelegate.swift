//
//  SceneDelegate.swift
//  Personality Quiz
//
//  Created by May Abdulla on 08/02/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        print("✅ SceneDelegate: Window scene connected")
        print("✅ Window Scene: \(windowScene)")
        print("✅ Window (before setup): \(String(describing: window))")
        print("✅ Root VC (before setup): \(String(describing: window?.rootViewController))")
        
        // If window is nil or root view controller is nil, manually set it up
        if window == nil || window?.rootViewController == nil {
            print("⚠️ Window or Root VC is nil - setting up manually...")
            
            // Create window if needed
            if window == nil {
                window = UIWindow(windowScene: windowScene)
                print("✅ Created new window")
            }
            
            // Load storyboard and set root view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let initialViewController = storyboard.instantiateInitialViewController() {
                window?.rootViewController = initialViewController
                print("✅ Set root view controller from Main storyboard: \(type(of: initialViewController))")
            } else {
                print("❌ ERROR: Could not instantiate initial view controller from Main.storyboard")
                print("❌ Make sure Main.storyboard has an initial view controller set (gray arrow)")
                
                // Set up a fallback blue screen so we can see SOMETHING
                setupFallbackViewController()
            }
            
            window?.makeKeyAndVisible()
            print("✅ Window made key and visible")
        }
        
        print("✅ Window (after setup): \(String(describing: window))")
        print("✅ Root VC (after setup): \(String(describing: window?.rootViewController))")
    }
    
    // MARK: - Fallback View Controller
    
    /// Creates a blue screen with helpful error message if storyboard fails to load
    private func setupFallbackViewController() {
        let testVC = UIViewController()
        testVC.view.backgroundColor = .systemBlue
        
        let label = UILabel()
        label.text = "⚠️ Storyboard Issue\n\nPossible problems:\n\n1. Main.storyboard doesn't exist\n2. No initial view controller set\n   (needs gray arrow)\n3. Storyboard not in build target\n\nCheck Project Navigator and\nAttributes Inspector"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        testVC.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testVC.view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: testVC.view.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: testVC.view.trailingAnchor, constant: -40)
        ])
        
        window?.rootViewController = testVC
        print("✅ Set up blue fallback view controller")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
