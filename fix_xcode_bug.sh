#!/bin/bash

echo "🔧 Fixing Xcode 16.2 System Bug..."
echo "=================================="

# Step 1: Complete Xcode cache cleanup
echo "Step 1: Cleaning Xcode caches..."
sudo rm -rf ~/Library/Developer/Xcode/DerivedData
sudo rm -rf ~/Library/Caches/com.apple.dt.Xcode
sudo rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport
sudo rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
sudo rm -rf ~/Library/Developer/Xcode/DerivedData/SDKStatCaches.noindex

# Step 2: Reset Xcode command line tools
echo "Step 2: Resetting Xcode command line tools..."
sudo xcode-select --reset

# Step 3: Accept Xcode license
echo "Step 3: Accepting Xcode license..."
sudo xcodebuild -license accept

# Step 4: Reset simulators
echo "Step 4: Resetting iOS simulators..."
xcrun simctl shutdown all
xcrun simctl erase all

# Step 5: Flutter cleanup
echo "Step 5: Cleaning Flutter environment..."
flutter clean
rm -rf ~/.pub-cache/hosted/pub.dev/*/
flutter pub cache repair
flutter pub get

# Step 6: iOS specific cleanup
echo "Step 6: Cleaning iOS build environment..."
cd ios 2>/dev/null || echo "Not in Flutter project directory"
rm -rf Pods Podfile.lock .symlinks build
cd ..

echo "✅ Xcode bug fix completed!"
echo "Now restart your Mac and try: flutter run"
echo "If still failing, use the manual build method."
