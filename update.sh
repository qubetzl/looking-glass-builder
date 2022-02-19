#!/usr/bin/env bash
# This script generates distribution specific Dockerfiles.
# The generated Dockerfile is determined by Dockerfile.template (used as a base) and config.json.
# Dockerfile.template is a 'template' that has placeholders starting and ending with %%
# These placeholders are replaced based on their respective values in config.json.

set -eu

configJsonFile="config.json"
configJsonContent="$(cat ${configJsonFile})"

function doNotEditNoticeText() {
    cat <<EOF
# This is Dockerfile is generated by "update.sh"
# Please, do not edit directly.
EOF
}

function filterJson() {
    local content="${1}"
    local filter="${2}"
    echo "${content}" | jq -r "${filter}"
}

variants="$(filterJson "${configJsonContent}" ".variants")"
numberOfVariants="$(filterJson "${variants}" "length")"

for (( i = 0; i < $numberOfVariants; i++ ))
do
    variant="$(filterJson "${variants}" ".[${i}]")"
    name="$(filterJson "${variant}" ".name")"
    echo "Generating ${name}"
    file="$(filterJson "${variant}" ".file")"
    dir="$(filterJson "${variant}" ".directory")"
    from="$(filterJson "${variant}" ".from")"
    # Combine dependency commands into one container layer
    # and make them readable in generated Dockerfile (adds ' && \\n    ' between them)
    dependencyCommands="$(filterJson "${variant}" ".dependency_commands | join(\" \\\\x26\\\\x26 \\\\x5C\\\\x0A    \")")"
    # Escape '/', since it is special character for sed
    dependencyCommandsEscaped="$(echo "${dependencyCommands}" | sed 's/\//\\x2F/g')"
    echo "file: ${file}"
    echo "dir: ${dir}"
    echo "from: ${from}"
    echo "dependencyCommands: ${dependencyCommands}"
    echo "dependencyCommandsEscaped: ${dependencyCommandsEscaped}"
    
    mkdir -p "${dir}"
    dockerfile="${dir}/${file}"

    # Generate Dockerfile template with notice
    { doNotEditNoticeText; cat Dockerfile.template; } | \
    # Replace values
    sed -e "s/%%FROM%%/${from}/g" \
        -e "s/%%DEPENDENCY_COMMANDS%%/${dependencyCommandsEscaped}/g" \
    > "${dockerfile}"
done
