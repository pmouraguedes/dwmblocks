#!/bin/bash

Fetch weather data
weather=$(curl -s 'wttr.in/Silveira?format=1' | tr -d ' ')
echo -e "$weather"
