#!/bin/bash

#set

#cat .config

make image FILES="$FILES" PACKAGES="$PACKAGES" DISABLED_SERVICES="$DISABLED_SERVICES"
