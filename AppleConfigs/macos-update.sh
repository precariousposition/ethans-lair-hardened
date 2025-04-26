# Author: Ethan Ross
# It: Updates macOS with logging, sanity checks, and cybersecurity best practices.
# Features: Logging, Dry Run, Security Checks, Dependency Updates

# Enable strict error handling
set -euo pipefail

# Configuration
LOG_FILE="$HOME/macos_update_$(date +%Y%m%d).log"
SUDO_PASSWORD="" # Leave empty for interactive prompt
DRY_RUN=false
VERBOSE=false

# Security parameters
VERIFY_UPDATES=true
CHECK_FIRMWARE=true
CLEANUP_OLD=true

# Initialize logging
log() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] $1" | tee -a "$LOG_FILE"
}

# Check for required privileges
check_privileges() {
    if [[ $EUID -ne 0 ]]; then
        log "Error: This script must be run as root"
        exit 1
    fi
}

# Verify Apple package signatures
verify_update_signatures() {
    log "Verifying package signatures..."
    pkgutil --check-signature / | tee -a "$LOG_FILE"
}

# Check firmware security
check_firmware_security() {
    log "Checking firmware security..."
    system_profiler SPiBridgeDataType | tee -a "$LOG_FILE"
    firmwarepasswd -check | tee -a "$LOG_FILE"
}

# Main update function
system_update() {
    log "Starting system updates..."
    
    if [ "$VERIFY_UPDATES" = true ]; then
        verify_update_signatures
    fi

    if [ "$CHECK_FIRMWARE" = true ]; then
        check_firmware_security
    fi

    # List available updates
    log "Available updates:"
    softwareupdate --list | tee -a "$LOG_FILE"

    # Install security updates first
    softwareupdate --install --all --force --agree-to-license | tee -a "$LOG_FILE"

    # Install recommended updates
    softwareupdate --install --recommended --force --agree-to-license | tee -a "$LOG_FILE"

    log "System updates completed successfully"
}

# Update third-party packages
update_packages() {
    log "Updating Homebrew packages..."
    if command -v brew &> /dev/null; then
        brew update | tee -a "$LOG_FILE"
        brew upgrade | tee -a "$LOG_FILE"
        brew cleanup | tee -a "$LOG_FILE"
    fi

    log "Updating MacPorts..."
    if command -v port &> /dev/null; then
        port selfupdate | tee -a "$LOG_FILE"
        port upgrade outdated | tee -a "$LOG_FILE"
        port clean --all installed | tee -a "$LOG_FILE"
    fi
}

# Post-update cleanup
cleanup_system() {
    if [ "$CLEANUP_OLD" = true ]; then
        log "Cleaning up old packages..."
        softwareupdate --all --force --install | tee -a "$LOG_FILE"
        softwareupdate --dump-state | tee -a "$LOG_FILE"
        rm -rf /Library/Updates/*
        periodic daily weekly monthly
    fi
}

# Security verification
post_update_checks() {
    log "Running security checks..."
    csrutil status | tee -a "$LOG_FILE"
    spctl --status | tee -a "$LOG_FILE"
    gatekeeper --status | tee -a "$LOG_FILE"
}

# Main execution flow
main() {
    check_privileges
    log "Starting macOS security update process"
    system_update
    update_packages
    cleanup_system
    post_update_checks
    log "Update process completed successfully"
}

# Parse arguments
while getopts ":dvc" opt; do
    case $opt in
        d) DRY_RUN=true;;
        v) VERBOSE=true;;
        c) CLEANUP_OLD=true;;
        \?) log "Invalid option -$OPTARG" >&2; exit 1;;
    esac
done

# Execute with error trapping
if [ "$DRY_RUN" = true ]; then
    log "Dry run mode enabled - no changes will be made"
    softwareupdate --list
    exit 0
else
    main
fi

exit 0