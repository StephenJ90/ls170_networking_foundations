#!/bin/bash

greeting () {
  echo "Hello $1"
  echo "Hello $2"
}

greeting 'Peter' 'Paul'

# This code will still work without the double quotes.