#
#  MyFiziqSDKHealthKit
#
#  Copyright (c) 2020 Bearn. All rights reserved.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

Pod::Spec.new do |s|
  s.name             = 'BearnSDK'
  s.version          = '1.0.0'
  s.summary          = 'BearnSDK summary'
  s.description      = "BearnSDK description"
  s.homepage         = 'https://berancorp.com'
  s.license          = "MIT"
  s.module_name      = 'BearnSDK'
  s.author           = { 'Bearn' => 'dev@berancorp.com' }
  s.source           = { :git => 'https://github.com/yurkins/BearnSDK.git', :branch => '1.0.0' }

  s.ios.deployment_target = '12.1'
  s.vendored_frameworks = 'BearnSDK.xcframework'
  s.frameworks = "BearnSDK"
  
  s.dependency 'Kingfisher'
  s.dependency 'Auth0'
  s.dependency 'JWTDecode'
  s.dependency 'OAuthSwift', '~> 2.0.0'
  s.dependency 'Plaid', '~> 2.0'
  
  # UI
  s.dependency 'IQKeyboardManagerSwift'
  s.dependency 'MBProgressHUD'
  s.dependency 'NotificationBannerSwift', '2.5.1'
  s.dependency 'Charts'
  s.dependency 'RangeSeekSlider'
  
  # MyFiziq
  s.dependency 'MyFiziqSDK', '~> 19.1.16'
  s.dependency 'MyFiziqSDKCommon'
  s.dependency 'MyFiziqSDKLoginView'
  s.dependency 'MyFiziqSDKInputView'
  s.dependency 'MyFiziqSDKOnboardingView'
  s.dependency 'MyFiziqSDKProfileView'
  s.dependency 'MyFiziqSDKTrackingView'
  s.dependency 'MyFiziqSDKBilling'
  s.dependency 'MyFiziqSDKHealthKit'
end
