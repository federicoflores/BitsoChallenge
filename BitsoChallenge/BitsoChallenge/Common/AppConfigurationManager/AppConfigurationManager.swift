//
//  AppConfigurationManager.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import Foundation

protocol AppConfigurationManagerType {
    func getAppConfiguration(with name: AppConfigurationManager.AppConfigurationNames) -> String?
}

class AppConfigurationManager: AppConfigurationManagerType {
    
    enum AppConfigurationNames: String {
        case API_BASE_HOST
        case API_IMAGE_HOST
    }
    
    static let shared: AppConfigurationManagerType = AppConfigurationManager()
    
    func getAppConfiguration(with name: AppConfigurationNames) -> String? {
        Bundle.main.object(forInfoDictionaryKey: name.rawValue) as? String
    }

}
