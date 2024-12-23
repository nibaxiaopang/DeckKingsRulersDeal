//
//  AppDelegate.swift
//  DeckKingsRulersDeal
//
//  Created by DeckKingsRulersDeal on 2024/12/23.
//

import UIKit
import Adjust

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AdjustDelegate {

    var sudoku: RulersDealSudokuClass = RulersDealSudokuClass()
    var load: RulersDealSudokuData?
    
    func getPuzzles(_ name : String) -> [String] {
        guard let url = Bundle.main.url(forResource: name, withExtension: "plist") else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let array = try? PropertyListDecoder().decode([String].self, from: data) else { return [] }
        return array
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let token = ""
        let environment = ADJEnvironmentProduction
        let myAdjustConfig = ADJConfig(
               appToken: token,
               environment: environment)
        myAdjustConfig?.delegate = self
        myAdjustConfig?.logLevel = ADJLogLevelVerbose
        Adjust.appDidLaunch(myAdjustConfig)
        
        return true
    }
    
    func adjustEventTrackingSucceeded(_ eventSuccessResponseData: ADJEventSuccess?) {
        print("adjustEventTrackingSucceeded")
    }
    
    func adjustEventTrackingFailed(_ eventFailureResponseData: ADJEventFailure?) {
        print("adjustEventTrackingFailed")
    }
    
    func adjustAttributionChanged(_ attribution: ADJAttribution?) {
        print("adid\(attribution?.adid ?? "")")

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func saveLocalStorage(save: RulersDealSudokuData) {
        // Use Filemanager to store Local files
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let saveURL = documentsDirectory.appendingPathComponent("sudoku_save")
                                        .appendingPathExtension("plist")
        // Encode and save to Local Storage
        //let propertyListEncoder = PropertyListEncoder()
        let saveGame = try? PropertyListEncoder().encode(save) // TODO: error here -- notes
        try? saveGame?.write(to: saveURL)
    } // end saveLocalStorage()
    
    // ---------------------[ Load Files ]-----------------------------
    func loadLocalStorage() -> RulersDealSudokuData {
        let documentsDirectory =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask).first!
        let loadURL = documentsDirectory.appendingPathComponent("sudoku_save").appendingPathExtension("plist")
        // Decode and Load from Local Storage
        if let data = try? Data(contentsOf: loadURL) {
            let decoder = PropertyListDecoder()
            load = try? decoder.decode(RulersDealSudokuData.self, from: data)
            // once loaded, delete save
            try? FileManager.default.removeItem(at: loadURL)
        }
        
        return load!
    }

}

