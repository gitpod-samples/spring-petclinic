#!/bin/sh

# skip indexing in regular workspaces
if [ ! "$GITPOD_HEADLESS" = "true" ] ; then exit ; fi

# index stable release
JB_BACKEND_DOWNLOAD_URL="https://download.jetbrains.com/product?type=release&distribution=linux&code=IIU"
echo "$JB_BACKEND_DOWNLOAD_URL"

# download JB backend
mkdir /tmp/backend && cd /tmp/backend || exit 1
curl -sSLo backend.tar.gz "$JB_BACKEND_DOWNLOAD_URL" && tar -xf backend.tar.gz --strip-components=1 && rm backend.tar.gz

# config JB system config and caches aligned with runtime
printf '\nshared.indexes.download.auto.consent=true' >> "/tmp/backend/bin/idea.properties"
unset JAVA_TOOL_OPTIONS
export IJ_HOST_CONFIG_BASE_DIR=/workspace/.config/JetBrains
export IJ_HOST_SYSTEM_BASE_DIR=/workspace/.cache/JetBrains

# start JB backend in indexing mode
/tmp/backend/bin/remote-dev-server.sh warmup "$GITPOD_REPO_ROOT"

# index latest release
JB_BACKEND_DOWNLOAD_URL="https://download.jetbrains.com/product?type=release,eap,rc&distribution=linux&code=IIU"
echo "$JB_BACKEND_DOWNLOAD_URL"

# download JB backend
mkdir /tmp/backend-latest && cd /tmp/backend-latest || exit 1
curl -sSLo backend-latest.tar.gz "$JB_BACKEND_DOWNLOAD_URL" && tar -xf backend-latest.tar.gz --strip-components=1 && rm backend-latest.tar.gz

# config JB system config and caches aligned with runtime
printf '\nshared.indexes.download.auto.consent=true' >> "/tmp/backend-latest/bin/idea.properties"
unset JAVA_TOOL_OPTIONS
export IJ_HOST_CONFIG_BASE_DIR=/workspace/.config/JetBrains-latest
export IJ_HOST_SYSTEM_BASE_DIR=/workspace/.cache/JetBrains-latest

# start JB backend in indexing mode
/tmp/backend-latest/bin/remote-dev-server.sh warmup "$GITPOD_REPO_ROOT"