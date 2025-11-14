#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# Rock Paper Scissors Lizard Spock – project setup
# -----------------------------------------------------------------------------
# Usage:
#   chmod +x setup.sh
#   ./setup.sh
#
# This will:
#   - create a Python virtual environment in .venv
#   - upgrade pip inside it
#   - install dependencies from requirements.txt
# -----------------------------------------------------------------------------

VENV_DIR=".venv"

# Function to print messages
log() {
  echo "[setup] $1"
}

# Check python3 exists
if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is not installed or not in PATH."
  echo "Please install Python 3 and try again."
  exit 1
fi

log "Using python: $(command -v python3)"
PY_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}')")
log "Python version: $PY_VERSION"

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
  log "Creating virtual environment in $VENV_DIR ..."
  python3 -m venv "$VENV_DIR"
else
  log "Virtual environment already exists in $VENV_DIR – skipping creation."
fi

# Activate venv (POSIX shells)
# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"

log "Virtual environment activated."

# Upgrade pip
log "Upgrading pip ..."
python -m pip install --upgrade pip

# Install requirements
if [ -f "requirements.txt" ]; then
  log "Installing dependencies from requirements.txt ..."
  pip install -r requirements.txt
else
  log "No requirements.txt found – skipping dependency installation."
fi

log "Setup complete."
echo
echo "Next steps:"
echo "  source $VENV_DIR/bin/activate"
echo "  python main.py   # once we create it"
