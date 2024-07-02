#!/bin/bash


parse_args() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --input_folder)
        input_folder="$2"
        shift 2
        ;;
      --extension)
        extension="$2"
        shift 2
        ;;
      --backup_folder)
        backup_folder="$2"
        shift 2
        ;;
      --backup_archive_name)
        backup_archive_name="$2"
        shift 2
        ;;
      *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
  done
}


parse_args "$@"


if [ -z "$input_folder" ] || [ -z "$extension" ] || [ -z "$backup_folder" ] || [ -z "$backup_archive_name" ]; then
  echo "Missing required arguments."
  exit 1
fi


mkdir -p "$backup_folder"

find "$input_folder" -type f -name "*.$extension" -exec cp --parents {} "$backup_folder" \;

tar -czf "$backup_archive_name" -C "$backup_folder" .

echo "done"
