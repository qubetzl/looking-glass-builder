#!/usr/bin/env bash

set -euo pipefail

LG_RELEASE="Release/B5"

function rebuildContainerAndLookingGlass() {
    dockerFile="${1}"
    baseImage="$(grep FROM ${dockerFile} | cut -d' ' -f2)"
    builderTag="$(echo ${baseImage} | cut -d':' -f2)"

    docker image pull ${baseImage}
    docker build -t looking-glass-builder:${builderTag} -f ${dockerFile} .

    docker container run --rm -t --env GIT_REF="${LG_RELEASE}" -v $(pwd):/build looking-glass-builder:${builderTag}

    rm looking-glass-client-*
}

function main() {
    find . -type f -name Dockerfile | {
        while read file; do 
            rebuildContainerAndLookingGlass "$file"; 
        done
    }
}

main
