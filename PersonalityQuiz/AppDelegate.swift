//
//  AppDelegate.swift
//  Personality Quiz
//
//  Created by May Abdulla on 08/02/2026.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("🚀 AppDelegate: didFinishLaunchingWithOptions called")
        
        // CRITICAL: Set up window manually
        setupWindowIfNeeded()
        
        // Configure app appearance
        configureAppearance()
        
        print("✅ AppDelegate: Finished launching")
        
        return true
    }
    
    // MARK: - Window Setup
    
    private func setupWindowIfNeeded() {
        print("🪟 Setting up window...")
        
        // Create window if it doesn't exist
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
            print("✅ Created window with frame: \(UIScreen.main.bounds)")
        }
        
        // Load Main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("✅ Loaded Main storyboard")
        
        if let initialViewController = storyboard.instantiateInitialViewController() {
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
            print("✅ Set root view controller: \(type(of: initialViewController))")
            print("✅ Window is now key and visible")
        } else {
            print("❌ ERROR: Could not instantiate initial view controller from Main.storyboard")
            createFallbackWindow()
        }
    }
    
    private func createFallbackWindow() {
        print("🔴 Creating fallback red screen...")
        
        let testVC = UIViewController()
        testVC.view.backgroundColor = .systemRed
        
        let label = UILabel()
        label.text = "⚠️ STORYBOARD ERROR\n\nMain.storyboard initial VC\nnot found"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        testVC.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: testVC.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: testVC.view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: testVC.view.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: testVC.view.trailingAnchor, constant: -40)
        ])
        
        window?.rootViewController = testVC
        window?.makeKeyAndVisible()
        print("🔴 Red fallback screen displayed")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("📱 AppDelegate: Configuring scene session")
        print("📱 Session role: \(connectingSceneSession.role)")
        
        let config = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        print("📱 Scene config name: \(config.name ?? "nil")")
        print("📱 Scene delegate class: \(String(describing: config.delegateClass))")
        
        return config
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Appearance Configuration
    
    /// Configure global app appearance
    private func configureAppearance() {
        // Set global tint color
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Set app-wide tint color (optional - customize to your preference)
        // window?.tintColor = .systemBlue
        
        print("✅ AppDelegate: Application launched successfully")
    }
}
