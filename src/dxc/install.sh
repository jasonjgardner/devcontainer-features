#!/bin/sh
set -e

echo "Activating feature 'DirectX Shader Compiler'"

RELEASE=${RELEASE:-undefined}
echo "The selected release version is: $RELEASE"

ASSET_URLS=(
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.8.2403.2/linux_dxc_2024_03_29.x86_64.tar.gz"
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.8.2403.1/linux_dxc_2024_03_22.x86_64.tar.gz"
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.8.2403/linux_dxc_2024_03_07.x86_64.tar.gz"
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.7.2308/linux_dxc_2023_08_14.x86_64.tar.gz"
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.8.2306-preview/linux_dxc_preview_2023_06_21.x86_64.tar.gz"
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.7.2212.1/linux_dxc_2023_03_01.x86_64.tar.gz"
    "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.7.2212/linux_dxc_2022_12_16.tar.gz"
)

DOWNLOAD_URL=${ASSET_URLS[0]}

for url in "${ASSET_URLS[@]}"
do
    if [[ $url == *"$RELEASE"* ]]; then
        DOWNLOAD_URL="${url}"
    fi
done

wget $DOWNLOAD_URL

tar -xzf linux_dxc_*
chmod +x $(pwd)/bin/dxc

export PATH=$PATH:$(pwd)/bin

echo "DXC version:"
dxc --version