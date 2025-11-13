#!/bin/bash

# Verification script for Viper examples
# This script helps download and run Viper verification tools

set -e

VIPER_DIR="./viper-tools"
VIPERSERVER_VERSION="2023.07.01"
VIPERSERVER_JAR="viperserver.jar"

echo "=== Viper Verification Script ==="

# Check Java installation
if ! command -v java &> /dev/null; then
    echo "Error: Java is not installed. Please install Java 11 or higher."
    exit 1
fi

echo "Java version:"
java -version

# Create tools directory if it doesn't exist
mkdir -p "$VIPER_DIR"

# Download ViperServer if not already present
if [ ! -f "$VIPER_DIR/$VIPERSERVER_JAR" ]; then
    echo ""
    echo "ViperServer not found. Download instructions:"
    echo "1. Visit: https://github.com/viperproject/viperserver/releases"
    echo "2. Download the latest viperserver JAR file"
    echo "3. Place it in: $VIPER_DIR/$VIPERSERVER_JAR"
    echo ""
    echo "Alternatively, use Viper IDE in Visual Studio Code:"
    echo "- Install VS Code"
    echo "- Install the 'Viper' extension"
    echo "- Open any .vpr file to verify automatically"
    echo ""
    exit 1
fi

# If we have ViperServer, we can use it
echo ""
echo "Starting ViperServer..."
java -jar "$VIPER_DIR/$VIPERSERVER_JAR" &
SERVER_PID=$!

sleep 3

echo "ViperServer started with PID: $SERVER_PID"
echo ""
echo "To verify files, you can now use the Viper IDE or send HTTP requests"
echo "to the ViperServer at http://localhost:8080"
echo ""
echo "Press Ctrl+C to stop the server"

# Wait for user to stop
wait $SERVER_PID
