#!/usr/bin/env bash
set -e
mkdir -p out
javac -d out src/simulator/*.java
jar --create --file LAB211Simulator.jar --main-class simulator.ShopeeSimulatorMain -C out .
java -jar LAB211Simulator.jar config.properties
