#!/usr/bin/env bash
set -e

# Install Flutter if not present
if ! command -v flutter > /dev/null 2>&1; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
  export PATH="$HOME/flutter/bin:$PATH"
fi

flutter --version
flutter pub get
flutter build web --release --web-renderer html