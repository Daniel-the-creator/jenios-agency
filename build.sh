#!/bin/bash
echo "Cloning Flutter SDK..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

echo "Adding Flutter to PATH..."
export PATH="$PATH:`pwd`/flutter/bin"

echo "Checking Flutter version..."
flutter --version

echo "Building Flutter Web app..."
flutter build web --release
