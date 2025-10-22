#!/bin/bash

# GitHub Actions utility script for dynamic package detection
# Detects all packages in packages/* directory and outputs as JSON array

set -euo pipefail

# Function to get package information
get_package_info() {
    local package_dir="$1"
    local package_json="$package_dir/package.json"

    if [[ ! -f "$package_json" ]]; then
        echo "Warning: No package.json found in $package_dir" >&2
        return 1
    fi

    # Extract package name from package.json
    local package_name
    package_name=$(jq -r '.name // empty' "$package_json" 2>/dev/null || echo "")

    if [[ -z "$package_name" ]]; then
        echo "Warning: No name field found in $package_json" >&2
        return 1
    fi

    # Extract package directory name (without packages/ prefix)
    local dir_name
    dir_name=$(basename "$package_dir")

    # Output package info as JSON
    jq -n \
        --arg name "$package_name" \
        --arg dir "$dir_name" \
        --arg path "$package_dir" \
        '{name: $name, dir: $dir, path: $path}'
}

# Main function
main() {
    local packages_dir="${1:-packages}"
    local output_format="${2:-json}"

    if [[ ! -d "$packages_dir" ]]; then
        echo "Error: Directory $packages_dir does not exist" >&2
        exit 1
    fi

    # Find all package directories
    local packages=()
    for package_dir in "$packages_dir"/*; do
        if [[ -d "$package_dir" && -f "$package_dir/package.json" ]]; then
            packages+=("$package_dir")
        fi
    done

    if [[ ${#packages[@]} -eq 0 ]]; then
        echo "Warning: No packages found in $packages_dir" >&2
        echo "[]"
        exit 0
    fi

    # Process each package
    local package_infos=()
    for package_dir in "${packages[@]}"; do
        if package_info=$(get_package_info "$package_dir" 2>/dev/null); then
            package_infos+=("$package_info")
        fi
    done

    # Output results
    case "$output_format" in
        "json")
            # Output as JSON array
            printf '%s\n' "${package_infos[@]}" | jq -s '.'
            ;;
        "names")
            # Output package names only
            printf '%s\n' "${package_infos[@]}" | jq -r '.name'
            ;;
        "dirs")
            # Output directory names only
            printf '%s\n' "${package_infos[@]}" | jq -r '.dir'
            ;;
        "matrix")
            # Output as GitHub Actions matrix format
            printf '%s\n' "${package_infos[@]}" | jq -s '{include: .}'
            ;;
        *)
            echo "Error: Unknown output format: $output_format" >&2
            echo "Supported formats: json, names, dirs, matrix" >&2
            exit 1
            ;;
    esac
}

# Check if jq is available
if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is required but not installed" >&2
    exit 1
fi

# Run main function with arguments
main "$@"
