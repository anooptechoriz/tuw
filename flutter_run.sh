#!/bin/bash

# Flutter Run Script with Fixed CocoaPods Environment
# This script ensures Flutter uses the correct CocoaPods installation

echo "🚀 Flutter Run with Fixed CocoaPods Environment"
echo "=============================================="

# Set correct environment
export PATH="/opt/homebrew/bin:$PATH"
unset RBENV_VERSION
unset RBENV_ROOT
export COCOAPODS_DISABLE_STATS=true

# Verify CocoaPods is working
echo "🔍 Verifying CocoaPods..."
pod_version=$(pod --version 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "✅ CocoaPods version: $pod_version"
else
    echo "❌ CocoaPods not working, installing via Homebrew..."
    brew install cocoapods
fi

# Navigate to project directory
cd /Users/techoriz/workspace/tuw

# Run Flutter
echo "🎯 Starting Flutter run..."
flutter run -d "iPhone 16"
