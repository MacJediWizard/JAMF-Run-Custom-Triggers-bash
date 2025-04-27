#!/bin/bash

#########################################################################################################################################################################
# MacJediWizard Consulting, Inc.
# Copyright (c) 2025 MacJediWizard Consulting, Inc.
# All rights reserved.
# Created by: William Grzybowski
#
# Script: run_custom_triggers.sh
#
# Description:
# - This script sequentially calls Jamf Pro custom triggers provided in a pre-defined list.
# - Stops execution immediately if any trigger fails.
# - Logs all actions, results, warnings, errors, and debug information into a customizable log file.
#
# Notes:
# - Must be run as root (required for jamf binary operations).
# - Designed for use inside a package postinstall script, a Jamf Pro policy, or standalone Terminal execution.
# - Jamf Pro Binary must be installed at /usr/local/bin/jamf.
#
# License:
# This script is licensed under the MIT License.
# See the LICENSE file in the root of this repository for details.
#
# Change Log:
# Version 1.0.0 - 2025-04-26
#   - Initial creation for project-specific use.
# Version 2.0.0 - 2025-04-26
#   - Refactored script to be generic for any Jamf Pro custom triggers.
#   - Added placeholder trigger names and log file.
# Version 2.1.0 - 2025-04-26
#   - Moved all configurable variables (log file name, trigger list, debug mode) to the top.
#   - Improved clarity and maintainability.
#########################################################################################################################################################################

set -o pipefail
set -u
set -e

#################################################################
# CONFIGURABLE VARIABLES - EDIT THESE ONLY
#################################################################

# Define your log file name (inside /var/log)
LOG_FILE="/var/log/{{ your_log_file_name }}"

# Define your custom triggers to execute in order
TRIGGERS_LIST=(
    "{{ trigger_one }}"
    "{{ trigger_two }}"
    "{{ trigger_three }}"
)

# Enable debug logging? (1 = yes, 0 = no)
DEBUG_MODE=0

#################################################################
# DO NOT EDIT BELOW THIS LINE
#################################################################

SCRIPT_VERSION="2.1.0"

# Logging Functions
log_info() { printf "[%s] [INFO] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"; }
log_warn() { printf "[%s] [WARN] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE" >&2; }
log_error() { printf "[%s] [ERROR] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE" >&2; }
log_debug() { [[ "$DEBUG_MODE" -eq 1 ]] && printf "[%s] [DEBUG] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"; }

# Prepare log file if needed
prepare_log_file() {
    if [[ ! -f "$LOG_FILE" ]]; then
        touch "$LOG_FILE"
        chmod 644 "$LOG_FILE"
    fi
}

# Validate Jamf Binary
validate_jamf_binary() {
    if [[ ! -x "/usr/local/bin/jamf" ]]; then
        log_error "Jamf binary not found or not executable at /usr/local/bin/jamf."
        return 1
    fi
    log_info "Jamf binary detected at /usr/local/bin/jamf."
}

# Run a single custom trigger
run_custom_trigger() {
    local trigger="$1"

    log_info "Executing custom trigger: $trigger"
    if /usr/local/bin/jamf policy -event "$trigger"; then
        log_info "Successfully completed trigger: $trigger"
    else
        log_error "Failed to execute trigger: $trigger"
        return 1
    fi
}

# Main Execution
main() {
    prepare_log_file

    log_info "Starting custom triggers execution script version $SCRIPT_VERSION"

    validate_jamf_binary || return 1

    for trigger in "${TRIGGERS_LIST[@]}"; do
        log_debug "Attempting to run trigger: $trigger"
        run_custom_trigger "$trigger" || return 1
    done

    log_info "All custom triggers executed successfully."
}

main