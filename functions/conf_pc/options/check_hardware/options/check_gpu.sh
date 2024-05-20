#!/bin/bash

gpu_raw=$(sudo lshw -class display)
vendor=$(echo $gpu_raw | grep vendor | awk '{$1=""; print $0}')

echo $vendor
