#!/bin/bash

# Quick iOS Module Cache Fix
echo "🔧 Quick iOS Fix - Creating module cache structure..."

# Remove and recreate module cache
rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex

# Create Session.modulevalidation
touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation

# Create all known problematic directories
mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/{1CL3H2PGYUAC7,1X9AJKXWMUIT5,2V5BH37492LF8,2B4W9D1ZCSXVS,1WW8UJLQCG5QJ,1VCYYLR47LO07,1TTSHFOBX977W}

echo "✅ Module cache structure created!"
echo "Now run: cd ios && xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max Fixed' -derivedDataPath /tmp/xcode_build_\$(date +%s) clean build"
