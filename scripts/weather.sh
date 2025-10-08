#!/bin/bash

# Fetch weather data for Mettmann
weather=$(curl -s 'wttr.in/Silveira?format=1' | tr -d ' ')
echo -e "$weather"
