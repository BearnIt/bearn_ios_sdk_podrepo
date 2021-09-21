# BearnSDK 
## 1. Requirements: XCode v12+, cocoapods v1.10+;


## 2. Add BearnSDK private repo. Command in terminal:
```bash
pod repo add bearn-private https://github.com/BearnIt/bearn_ios_sdk_podrepo
```
```
username: your-github-user
password: your-github-password
```
*NOTE: Ask for access to the repo if your user has no access to it.


## 3. Add MyFiziqSDK private repo. Command in terminal:
```bash
pod repo add myfiziq-private https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/myfiziq-sdk-podrepo
```
```
username: bearn-will-provide
password: bearn-will-provide
```

## 4. In project podfile:

```bash
source 'https://github.com/BearnIt/bearn_ios_sdk_podrepo'
source 'https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/myfiziq-sdk-podrepo'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.1'

use_frameworks!
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
  pod "BearnSDK"
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
         config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
```

## 5. Add keys to `Info.plist` :
```      
        <key>CFBundleURLTypes</key>
        <array>
                <dict>
                        <key>CFBundleTypeRole</key>
                        <string>None</string>
                        <key>CFBundleURLName</key>
                        <string>auth0-dev</string>
                        <key>CFBundleURLSchemes</key>
                        <array>
                                <string>gpi.BearnDev</string>
                        </array>
                </dict>
                <dict>
                        <key>CFBundleTypeRole</key>
                        <string>None</string>
                        <key>CFBundleURLName</key>
                        <string>auth0-prod</string>
                        <key>CFBundleURLSchemes</key>
                        <array>
                                <string>ios.Bearn</string>
                        </array>
                </dict>
                <dict>
                        <key>CFBundleTypeRole</key>
                        <string>Editor</string>
                        <key>CFBundleURLName</key>
                        <string>fitbit</string>
                        <key>CFBundleURLSchemes</key>
                        <array>
                                <string>oauth-bearn</string>
                        </array>
                </dict>
        </array>


        <key>NSAppTransportSecurity</key>
        <dict>
                <key>NSAllowsArbitraryLoads</key>
                <true/>
        </dict>
        
        <key>NSCameraUsageDescription</key>
        <string>This app requires access to the camera to capture accurate body measurements from photos.</string>
        
        <key>NSHealthShareUsageDescription</key>
        <string>YOUR_APP_NAME app uses the Health app to pull in heart-rate, resting heart-rate, steps and calories data in order to convert the data into cash.</string>
        
        <key>NSHealthUpdateUsageDescription</key>
        <string>YOUR_APP_NAME app uses the Health app to pull in heart-rate, resting heart-rate, steps and calories data in order to convert the data into cash.</string>
        
        <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
        <string>Allow "YOUR_APP_NAME" to access your location while you are using the app?</string>
        
        <key>NSLocationAlwaysUsageDescription</key>
        <string>Allow "YOUR_APP_NAME" to access your location while you are using the app?</string>


        <key>NSLocationWhenInUseUsageDescription</key>        
        <string>"YOUR_APP_NAME" app needs your location to send you the most appropriate offers based on your current location.</string>
```

## 6. Select `YourProject->TargetName-> Signing & Capabilities` tab -> +(Add) `HealthKit`


## 7. Setup code for BearnSDK in AppDelegate & SceneDelegate:

```swift
// In AppDelegate.swift
import BearnSDK
……………………………………………………………………………………
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Bearn.setupEnvironment(.development) // For Production set .production
        return true
    }

// For old projects with AppDelegate only
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if Bearn.shared.isBearnURL(url: url) {
            return Bearn.shared.handle(url: url, options: options)
        }
        return true
    }

// For new projects with SceneDelegate.swift 
import BearnSDK
……………………………………………………………………………………     
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url, Bearn.shared.isBearnURL(url: url) {
            Bearn.shared.handle(url: url, options: [:])
        }
    }
```

## 8. Show Bearn:

```swift
import BearnSDK
class ViewController: UIViewController {
……………………………………………………………………………………
    @IBAction func btnShowTouch(_ sender: Any) {
        Bearn.shared.present(on: self)
    }
}
```
