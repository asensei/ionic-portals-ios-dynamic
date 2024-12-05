#!/bin/bash
set -ev

# Clean previous builds
rm -rf build

# Create build directories
mkdir -p build

# Build for device
xcodebuild archive \
    -scheme IonicPortals \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    -archivePath build/iphoneos.xcarchive \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    OTHER_SWIFT_FLAGS="-no-verify-emitted-module-interface"

# Build for simulator
xcodebuild archive \
    -scheme IonicPortals \
    -configuration Release \
    -destination 'generic/platform=iOS Simulator' \
    -archivePath build/iphonesimulator.xcarchive \
    ENABLE_BITCODE=NO \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    OTHER_SWIFT_FLAGS="-no-verify-emitted-module-interface"

# Print out actual paths
DEVICE_FRAMEWORK_PATH=$(find build/iphoneos.xcarchive -name "IonicPortals.framework" | head -n 1)
SIMULATOR_FRAMEWORK_PATH=$(find build/iphonesimulator.xcarchive -name "IonicPortals.framework" | head -n 1)

echo "Device Framework Path: $DEVICE_FRAMEWORK_PATH"
echo "Simulator Framework Path: $SIMULATOR_FRAMEWORK_PATH"

# Verify framework existence
[ -d "$DEVICE_FRAMEWORK_PATH" ] || { echo "Device framework not found"; exit 1; }
[ -d "$SIMULATOR_FRAMEWORK_PATH" ] || { echo "Simulator framework not found"; exit 1; }

# Create XCFramework
xcodebuild -create-xcframework \
    -framework "$DEVICE_FRAMEWORK_PATH" \
    -framework "$SIMULATOR_FRAMEWORK_PATH" \
    -output build/IonicPortals.xcframework

rm -rf /Users/tj/projects/capacitor-plugin-asensei-sdk/ios/Example/AsenseiSdkSwiftModule/IonicPortals.xcframework
cp -r build/IonicPortals.xcframework /Users/tj/projects/capacitor-plugin-asensei-sdk/ios/Example/AsenseiSdkSwiftModule/