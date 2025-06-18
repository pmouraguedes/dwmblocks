#!/bin/bash

# Fetch weather data for Mettmann
weather=$(curl -s 'wttr.in/Mettmann?format=1' | tr -d ' ')
echo -e "$weather"
