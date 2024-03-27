#!/bin/bash

check_user() {

  check=0
  
  if [ $(whoami) = "root" ]; then
  
    check=1
  
  fi
  
}
