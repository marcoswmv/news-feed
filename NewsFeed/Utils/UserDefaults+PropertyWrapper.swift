//
//  UserDefaults+Extension.swift
//  NewsFeed
//
//  Created by Marcos Vicente on 15/6/21.
//

import UIKit

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let value = UserDefaults.standard.object(forKey: key) as? Data,
                  let decodedValue = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value) else {
                return self.defaultValue
            }
            
            return decodedValue as? T ?? self.defaultValue
        }
        set {
            switch newValue {
            case let value as Optional<Any>:
                
                switch value {
                case .none:
                    UserDefaults.standard.removeObject(forKey: key)
                case .some(let wrappedValue):
                    do {
                        let encodedWrappedDataValue = try NSKeyedArchiver.archivedData(withRootObject: wrappedValue, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedWrappedDataValue, forKey: key)
                    } catch {
                        Alert.showErrorAlert(on: UIApplication.topViewController()!, message: error.localizedDescription)
                    }
                }
            default:
                do {
                    let encodedWrappedDataValue = try NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedWrappedDataValue, forKey: key)
                } catch {
                    Alert.showErrorAlert(on: UIApplication.topViewController()!, message: error.localizedDescription)
                }
            }
            
            UserDefaults.standard.synchronize()
        }
    }
}
