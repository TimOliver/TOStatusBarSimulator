# TOStatusBarSimulator
> Replaces the iOS system status bar with a configurable version that can be used for nicer looking screen captures/recordings of your app!

<p align="center">
<img src="https://raw.githubusercontent.com/TimOliver/TOStatusBarSimulator/master/screenshot.jpg" width="582" height="215" style="margin: 0 auto;" />
</p>

The system status bar is a very iconic part of iOS, visible in the vast majority of screenshots taken from the platform.

When it comes to marketing screenshots, Apple have a very strict branding policy on what the status bar looks like. Full signal strength, WiFi icon, "9:41AM" and full battery:

<p align="center">
<img src="https://raw.githubusercontent.com/TimOliver/TOStatusBarSimulator/master/status-bar-apple-standard.jpg" width="620" height="30" style="margin: 0 auto;" />
</p>

Unfortunately, the vast majority of apps on the App Store usually have some flavor of the following:

<p align="center">
<img src="https://raw.githubusercontent.com/TimOliver/TOStatusBarSimulator/master/status-bar-comparison.jpg" width="620" height="92" style="margin: 0 auto;" />
</p>

1. Taken on a real device, showing the user's telco name, an arbitrary time, any number of icons, and a half-empty battery.
2. Taken straight from the iOS Simulator, with the 'Carrier' string and everything.
3. Captured from a device that was plugged into QuickTime Player for screen recording. The signal strength and time are standard, but the device icons and battery icon are still inconsistent.

When integrated into an app, `TOStatusBarSimulator` will replace the real status bar with a simulated one, designed to perfectly emulate the same style of status bar in Apple's marketing screenshots and videos.

This library is great for making screenshots, and even screen recordings of your app all showing the same consistent status bar style. 

It's also great if showcasing your apps on a demo iOS device in kiosk mode, allowing for an additional layer of polish and branding.

# Features
* Overrides the system status bar in favor of a mockup that can be fully controlled.
* Hooks into the original system status bar and will automatically hide and change tint color as needed.
* Show's "9:41 AM" by default, but can also show the system clock.
* Carrier string can be manually changed, allowing for things such as displaying your company name.

# Requirements
iOS 8.0 and above

# Installation

## CocoaPods
[CocoaPods](http://cocoapods.org) is the preferred method of installing this library, as you can easily limit its integration to only your debug builds.

Add the following to your `Podfile`:
```
pod 'TOStatusBarSimulator', :configurations => ['Debug']
```

## Manually
Drag the folder `TOStatusBarSimulator` into your Xcode project. Make sure `Copy Items if Needed` is checked to ensure a copy is imported into your Xcode project folder properly.

Be sure to remove the library from your project when you're ready to ship to avoid any risk of getting rejected by Apple.

# Usage
`TOStatusBarSimulator` is controlled via issuing commands through a set of class methods. These can be called at any point in your app's execution:

```objc
[TOStatusBarSimulator show];
[TOStatusBarSimulator setCarrierString:@"🤣"];
[TOStatusBarSimulator showActualTime:YES];
```


# Is it App Store safe?
Most likely not. Although there is private API access in this library, it's limited to manipulation via strings, so it's possible that Apple might not detect it.

In any case, there's no reason why users would want this functionality in a production level app, so it's definitely recommended that you only include it in your debug builds.

# License

This library is licensed under the MIT license. Please see [LICENSE](LICENSE) for more details.

# Credits
`TOStatusBarSimulator` was created by [Tim Oliver](http://twitter.com/TimOliverAU).

iPhone 7 Plus device mockup by [Pixeden](http://pixeden.com).
