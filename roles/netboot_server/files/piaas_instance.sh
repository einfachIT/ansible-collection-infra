function create() {
  declare -A args=(
    ["name"]=""
    ["image"]=""
  )

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --name|-n)
        args["name"]="$2"
        shift 2
        ;;
      --image|-i)
        args["image"]="$2"
        shift 2
        ;;
      *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
  done

  if [ ! -d /nfs/${args["name"]} ]; then
    mkdir /nfs/${args["name"]}
    losetup -P /dev/loop0 /data/images/${args["image"]}.img
    mkdir /mnt/${args["image"]}
    mount -o ro -t ext4 /dev/loop0p2 /mnt/${args["image"]}
    mount -o ro -t vfat /dev/loop0p1 /mnt/${args["image"]}/boot
    rsync -a /mnt/${args["image"]}/ /nfs/${args["name"]}
    sudo umount /mnt/${args["image"]}/boot
    sudo umount /mnt/${args["image"]}
    sudo losetup -d /dev/loop0
    rm -rf /mnt/${args["name"]}
  else
    echo instance with name ${args["name"]} already exists
  fi

}

if [[ "$1" != "_"* ]]; then
  "$@"
else
  echo "Unknown subcommand: $1"
fi
