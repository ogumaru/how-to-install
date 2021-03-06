#!/bin/bash

set -ue

# Environments
declare -r SELF_DIR="$(dirname "$(readlink -f "${BASH_SOURCE}")")"
declare -r PACKAGE_LIST_DIR="${SELF_DIR}/package/$(lsb_release -si)/$(lsb_release -sr)/$(uname -m)"
declare -r PACKAGE_LIST_DIR_ALL="${SELF_DIR}/package"

# Constants
declare -r EXIT_SUCCESS=0
declare -r EXIT_FAILURE=1

declare -r SWITCH_TRUE=1
declare -r SWITCH_FALSE=0

declare -ar SWITCHES_UNINSTALL=('--uninstall' '--remove' '-u' '-r')
declare -ar SWITCHES_LIST_PACKAGES_ALL=('--list' '-l')

# Helper functions
function is_includes() {
  declare -r value="$1"
  shift
  declare -ar array=("$@")
  for member in "${array[@]}"; do
    if [[ "${value}" == "${member}" ]]; then
      return "${EXIT_SUCCESS}"
    fi
  done
  return "${EXIT_FAILURE}"
}

function list_packages_all() {
  printf "ID\trelease\tarch\tpackage\n"
  find "${PACKAGE_LIST_DIR_ALL}" -mindepth 4 -maxdepth 4 -type d | xargs -I %f bash -c 'sed -e "s|^.*/package/||g" -e "s|/|\t|g" <<<%f'
}

function main() {
  if [[ "$#" -le 0 ]]; then
    {
      echo 'Packages:'
      ls -1 "${PACKAGE_LIST_DIR}"
    } >&2
    exit "${EXIT_FAILURE}"
  fi

  if is_includes "$1" "${SWITCHES_LIST_PACKAGES_ALL[@]}"; then
    list_packages_all
    exit "${EXIT_SUCCESS}"
  fi

  if [[ "$#" -eq 2 ]] && is_includes "$1" "${SWITCHES_UNINSTALL[@]}"; then
    declare -r is_uninstall="${SWITCH_TRUE}"
    declare -r package="$2"
  else
    declare -r is_uninstall="${SWITCH_FALSE}"
    declare -r package="$1"
  fi
  declare -r package_dir="$(find "${PACKAGE_LIST_DIR}" -name "${package}" 2>/dev/null)"

  # Package not found
  if [[ "${package_dir}" == "" ]]; then
    {
      echo 'No such package'
    } >&2
    exit "${EXIT_FAILURE}"
  fi

  if [[ "${is_uninstall}" -eq "${SWITCH_TRUE}" ]]; then
    cat "${package_dir}/uninstall.sh"
  else
    cat "${package_dir}/install.sh"
  fi
}

main "$@"
