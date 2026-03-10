#!/bin/bash

clone_repo() {
    REPO_URL=$1
    DEST=$2
    BRANCH=$3

    echo ""
    echo "Cloning: $(basename $REPO_URL)"
    git clone --depth=1 -b "$BRANCH" "$REPO_URL" "$DEST"
}

# ========================
# Fetch branches from device tree only
# ========================
DEVICE_REPO="https://github.com/BlueHeart01/device_xiaomi_redwood.git"

echo ""
echo "======================================"
echo "Fetching branches from device tree..."
echo "======================================"

branches=($(git ls-remote --heads "$DEVICE_REPO" | awk '{print $2}' | sed 's|refs/heads/||'))

echo ""
echo "Available branches:"
echo "-------------------"
for i in "${!branches[@]}"; do
    echo " $((i+1))) ${branches[$i]}"
done
echo ""

read -p "Select branch number: " selection

if ! [[ "$selection" =~ ^[0-9]+$ ]] || (( selection < 1 || selection > ${#branches[@]} )); then
    echo "Invalid selection!"
    exit 1
fi

BRANCH="${branches[$((selection-1))]}"
echo ""
echo "Selected branch: $BRANCH"

# ========================
# Clone all repos
# ========================
clone_repo https://github.com/BlueHeart01/device_xiaomi_redwood.git device/xiaomi/redwood "$BRANCH"
clone_repo https://github.com/BlueHeart01/vendor_xiaomi_redwood.git vendor/xiaomi/redwood "$BRANCH"
clone_repo https://github.com/Redwood-AOSP/android_device_xiaomi_redwood-kernel.git device/xiaomi/redwood-kernel "$BRANCH"
clone_repo https://github.com/BlueHeart01/redwood_vendor_xiaomi_redwood-miuicamera.git vendor/xiaomi/redwood-miuicamera "$BRANCH"
clone_repo https://github.com/BlueHeart01/vendor_oneplus_dolby.git vendor/oneplus/dolby "$BRANCH"
clone_repo https://github.com/BlueHeart01/hardware_xiaomi.git hardware/xiaomi "$BRANCH"
clone_repo https://github.com/BlueHeart01/vendor_bcr.git vendor/bcr "$BRANCH"

echo ""
echo "All repositories cloned successfully."
