#!/usr/bin/env bash

function install() {
  declare -A args=(
    ["name"]=""
    ["url"]=""
  )

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --name|-n)
        args["name"]="$2"
        shift 2
        ;;
      --url|-u)
        args["url"]="$2"
        shift 2
        ;;
      *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
  done

  curl ${args["url"]} -o  /data/images/${args["name"]}.img.xz
  cd /data/images
  unxz ${args["name"]}.img.xz
}

function _helper1() {
  echo "helper1"
}

if [[ "$1" != "_"* ]]; then
  "$@"
else
  echo "Unknown subcommand: $1"
fi
