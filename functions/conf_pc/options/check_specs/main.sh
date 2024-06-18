#!/bin/bash

title="Administración del servidor $(hostname)"

dialog --title "$title" --msgbox "$(neofetch --stdout \
    --info "OS" distro \
    --info "Host" model \
    --info "Kernel" kernel \
    --info "Uptime" uptime \
    --info "Packages" packages \
    --info "Shell" shell \
    --info "GPU" gpu \
    --info "GPU Driver" gpu_driver \
    --info "CPU" cpu \
    --info "CPU Usage" cpu_usage \
    --info "Disk" disk \
    --info "Memory" memory \
    --info "Local IP" local_ip \
    --info "Users" users \
    --info "Date" date \
    --cols)" 0 0
