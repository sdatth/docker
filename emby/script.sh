#!/bin/bash
# ------------------------------------------------------------
# Hard-coded video cleaner for your setup
# Cleans $HOME/docker/qbittorrent/downloads/
# Moves cleaned folders to $HOME/docker/emby/movies/
# ------------------------------------------------------------

set -euo pipefail
shopt -s globstar nullglob

# --- Paths ---
target_dir="$HOME/docker/qbittorrent/downloads"
dest_dir="$HOME/docker/emby/movies"

mkdir -p "$dest_dir"

# --- Allowed extensions ---
allowed_exts="mp4|mkv|avi|mov|wmv|flv|webm|srt|sub"

# --- Protect the script itself ---
script_path="$(realpath "$0")"

rename_text() {
  local base="$1"
  # Clean name logic reused
  clean=$(echo "$base" | sed 's/[(\[].*[])]//g')
  clean=$(echo "$clean" | sed 's/[^A-Za-z0-9 .-]//g')
  clean=$(echo "$clean" | sed 's/^ *//;s/ *$//')
  clean=$(echo "$clean" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  clean=$(echo "$clean" | sed 's/-\+/-/g')
  echo "$clean"
}

rename_item() {
  local item="$1"
  [[ "$item" == "." || "$item" == ".." ]] && return

  if [ -f "$item" ]; then
    ext="${item##*.}"
    name="${item%.*}"
  else
    ext=""
    name="$item"
  fi

  base=$(basename "$name")
  dir=$(dirname "$item")
  clean=$(rename_text "$base")

  if [ -f "$item" ]; then
    newpath="$dir/$clean.${ext}"
  else
    newpath="$dir/$clean"
  fi

  if [[ "$item" != "$newpath" ]]; then
    echo "Renaming: '$item' → '$newpath'"
    mv -i -- "$item" "$newpath"
  fi
}

# --- Process each subfolder in downloads ---
for subdir in "$target_dir"/*/; do
  [ -d "$subdir" ] || continue
  echo "🚀 Cleaning folder: $subdir"

  cd "$subdir"

  # Rename inner directories first
  find . -depth -type d -print0 | while IFS= read -r -d '' dir; do
    rename_item "$dir"
  done

  # Rename and clean files
  find . -type f -print0 | while IFS= read -r -d '' file; do
    [[ "$(realpath "$file")" == "$script_path" ]] && continue
    ext="${file##*.}"
    if [[ "$ext" =~ ^($allowed_exts)$ ]]; then
      rename_item "$file"
    else
      echo "🗑️ Deleting: $file"
      rm -f -- "$file"
    fi
  done

  # Remove empty directories
  find . -type d -empty -not -path "." -delete

  cd "$target_dir"

  # --- Rename the main folder itself before moving ---
  folder_name="$(basename "$subdir")"
  clean_folder_name=$(rename_text "$folder_name")
  clean_folder_path="$target_dir/$clean_folder_name"

  if [[ "$subdir" != "$clean_folder_path/" ]]; then
    echo "Renaming main folder: '$folder_name' → '$clean_folder_name'"
    mv -i -- "$subdir" "$clean_folder_path"
  fi

  # Move cleaned folder to videos
  dest_path="$dest_dir/$clean_folder_name"
  echo "📦 Moving cleaned folder to: $dest_path"
  mv -f "$clean_folder_path" "$dest_path"
done

echo "✅ All folders in '$target_dir' cleaned, renamed, and moved to '$dest_dir'!"
