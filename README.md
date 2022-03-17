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

## 3. In project podfile:

```bash
source 'https://github.com/BearnIt/bearn_ios_sdk_podrepo'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.4'

use_frameworks!
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
  pod "BearnSDK"
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 13.4
         config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.4'
      end
    end
  end
end
```
*NOTE: in some cases need to use `pod install --repo-update` instead of `pod install`

## 4. Add keys to `Info.plist` :
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

## 5. Select `YourProject->TargetName-> Signing & Capabilities` tab -> +(Add) `HealthKit`


## 6. Setup code for BearnSDK in AppDelegate & SceneDelegate:

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

## 7. Show Bearn:

```swift
import BearnSDK
class ViewController: UIViewController {
……………………………………………………………………………………
    @IBAction func btnShowTouch(_ sender: Any) {
        Bearn.shared.present(on: self)        
    }
}
```

## 8. Show Bearn Federated Login:

```swift
import BearnSDK
class ViewController: UIViewController {
……………………………………………………………………………………
    @IBAction func btnFederatedLoginTouch(_ sender: Any) {
        Bearn.shared.loadDefaultTheme()
        Bearn.shared.present(on: self,
                             parterId: "22ffa303-6c84-11ea-adfe-0e4cb9ff8a2a",
                             firstName: "John",
                             lastName: "Doe",
                             email: "john.doe@anymail.com",
                             externalId: "121212121212121212121221",
                             token: "11ffa303-6c84-11ea-adfe-0e4cb9ff1234")
    }
}
```

*NOTE: Ask Bearn for **parterId**.



## 9. Customizing strings inside the app.

Most of the SDK strings can be changed by proving a .strings file.

Use the loadCustomInfoFrom function to pass the name of the string file that the SDK should use, you can ommit the file .strings extension. In case you have the .strings file in a bundle other than the main bundle, you can pass the bundle to the same function. By default it will use the main app bundle.


```swift
import BearnSDK
class ViewController: UIViewController {
……………………………………………………………………………………
    @IBAction func btnShowTouch(_ sender: Any) {
        Bearn.shared.loadCustomInfoFrom(localizationStringsFile: "BearnStrings")
        Bearn.shared.present(on: self)        
    }
}
```

Sample for providing the custom bundle:
```swift
Bearn.shared.loadCustomInfoFrom(bundle: .main, localizationStringsFile: "BearnStrings")
```

## 10. Customizing colors inside the app.

Most of the UI colors inside the SDK are customizable based on each element accessibility identifier (if declared). The color styling implementation is based on a JSON file that declares all the global colors used across the entire SDK and each screen UI elements color declaration. Most screens have an identifier that can be found in the demo BearnColors.json file, this will be the key in the JSON file under which all child elements can be customized.

To load the colors JSON file use the same function that we use for loading strings just with an extra parameter. Example:

```swift
import BearnSDK
class ViewController: UIViewController {
……………………………………………………………………………………
    @IBAction func btnShowTouch(_ sender: Any) {
        Bearn.shared.loadCustomInfoFrom(bundle: .main, localizationStringsFile: "BearnStrings", localizationColorsFile: "BearnColors.json")
        Bearn.shared.present(on: self)        
    }
}
```
All colors are declared in hex format. When we want to use a globally declared color we will declare the color name with a "@" prefix. E.g ```@bearnText``` where ```bearnText``` is declared in the global colors section. Additionally if the color needs to have the alpha channel changed then it can be declared as such ```@bearnText:0.5```, this will result in the bearnText color with 0.5 alpha channel.

Some buttons can be have each state configurable. For example, to customiza the normal state and the selectate state for a button with accessibility identifier set to ```report_option_4``` we will use the following JSON:

```json
        "report_option_4": {
            "normal": {
                "text": "#000000",
                "background": "#FFFFFF"
            },
            "selected": {
                "text": "#000000",
                "background": "@grey"
            }
        }
```

Where `text` represents the titleLabel text color for each state and background is the background color for each state. In addition to the `normal` and `selected state`, the `disabled` and `highlighted` state are also supported. Please note that not all buttons support this by default, in case you need better customization support, please feel free to contact us.

Another example for customizing alerts with 2 buttons (Yes and NO) will look like this:

```json 
    "yesAndNoAlert": {
        "yesButton": {
            "text": "#FFFFFF",
            "background": "@bearnGreen"
        },
        "noButton": {
            "text": "@bearnAzureGreen",
            "background": "#FFFFFF"
        },
        "titleLabel": "#000000"
    }
```

Where `yesAndNoAlert` is the key name of the screen, `yesButton` is the key for the yes (main) button and `noButton` for No button. `titleLabel` key will represent the color for our alert message label.

Please note: when you do not declare the styles for each individual button state, the values will be assigned only for the normal state by default. 



