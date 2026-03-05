#!/bin/bash

clone_repo() {
    REPO_URL=$1
    DEST=$2

    echo ""
    echo "======================================"
    echo "Repository: $REPO_URL"
    echo "Destination: $DEST"
    echo "Fetching branches..."
    echo "======================================"

    # Fetch branches
    branches=$(git ls-remote --heads "$REPO_URL" | awk '{print $2}' | sed 's|refs/heads/||')

    echo ""
    echo "Available branches:"
    echo "-------------------"

    for b in $branches; do
        echo " - $b"
    done

    echo ""
    read -p "Enter branch to clone: " branch

    if [[ ! "$branches" =~ "$branch" ]]; then
        echo "Branch '$branch' not found!"
        exit 1
    fi

    echo ""
    echo "Cloning $branch ..."
    echo ""

    git clone --depth=1 -b "$branch" "$REPO_URL" "$DEST"
}

# ========================
# Clone repos
# ========================

clone_repo https://github.com/BlueHeart01/device_xiaomi_redwood.git device/xiaomi/redwood

clone_repo https://github.com/BlueHeart01/vendor_xiaomi_redwood.git vendor/xiaomi/redwood

clone_repo https://github.com/Redwood-AOSP/android_device_xiaomi_redwood-kernel.git device/xiaomi/redwood-kernel

clone_repo https://github.com/BlueHeart01/redwood_vendor_xiaomi_redwood-miuicamera.git vendor/xiaomi/redwood-miuicamera

clone_repo https://github.com/BlueHeart01/vendor_oneplus_dolby.git vendor/oneplus/dolby

clone_repo https://github.com/BlueHeart01/hardware_xiaomi.git hardware/xiaomi

clone_repo https://github.com/BlueHeart01/vendor_bcr.git vendor/bcr

echo ""
echo "All repositories cloned successfully."
