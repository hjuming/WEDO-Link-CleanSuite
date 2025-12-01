#!/bin/bash

# Define the list of icons
ICONS=(
  "app-icon.png"
  "installer-icon.png"
  "prefpane-menu-icon.png"
  "clean-weekly-deep.png"
  "clean-daily.png"
  "clean-low-storage.png"
  "clean-mail.png"
  "clean-chrome.png"
  "clean-line.png"
  "clean-safari.png"
  "clean-boot-quick.png"
)

BASE_DIR="assets/icons"
GEN_DIR="assets/icons/generated"

mkdir -p "$GEN_DIR"

for icon in "${ICONS[@]}"; do
    filename=$(basename "$icon")
    name="${filename%.*}"
    
    # Create .iconset folder
    iconset_dir="$GEN_DIR/$name.iconset"
    mkdir -p "$iconset_dir"
    
    source_file="$BASE_DIR/$filename"
    
    if [ ! -f "$source_file" ]; then
        echo "Warning: Source file $source_file not found. Skipping."
        continue
    fi
    
    echo "Generating iconset for $name..."
    
    # Standard sizes
    sips -z 16 16     "$source_file" --out "$iconset_dir/icon_16x16.png" > /dev/null
    sips -z 32 32     "$source_file" --out "$iconset_dir/icon_16x16@2x.png" > /dev/null
    sips -z 32 32     "$source_file" --out "$iconset_dir/icon_32x32.png" > /dev/null
    sips -z 64 64     "$source_file" --out "$iconset_dir/icon_32x32@2x.png" > /dev/null
    sips -z 128 128   "$source_file" --out "$iconset_dir/icon_128x128.png" > /dev/null
    sips -z 256 256   "$source_file" --out "$iconset_dir/icon_128x128@2x.png" > /dev/null
    sips -z 256 256   "$source_file" --out "$iconset_dir/icon_256x256.png" > /dev/null
    sips -z 512 512   "$source_file" --out "$iconset_dir/icon_256x256@2x.png" > /dev/null
    sips -z 512 512   "$source_file" --out "$iconset_dir/icon_512x512.png" > /dev/null
    sips -z 1024 1024 "$source_file" --out "$iconset_dir/icon_512x512@2x.png" > /dev/null
    
    # Create Contents.json for each iconset (standard Xcode format)
    cat <<EOF > "$iconset_dir/Contents.json"
{
  "images" : [
    { "idiom" : "mac", "size" : "16x16",  "scale" : "1x", "filename" : "icon_16x16.png" },
    { "idiom" : "mac", "size" : "16x16",  "scale" : "2x", "filename" : "icon_16x16@2x.png" },
    { "idiom" : "mac", "size" : "32x32",  "scale" : "1x", "filename" : "icon_32x32.png" },
    { "idiom" : "mac", "size" : "32x32",  "scale" : "2x", "filename" : "icon_32x32@2x.png" },
    { "idiom" : "mac", "size" : "128x128", "scale" : "1x", "filename" : "icon_128x128.png" },
    { "idiom" : "mac", "size" : "128x128", "scale" : "2x", "filename" : "icon_128x128@2x.png" },
    { "idiom" : "mac", "size" : "256x256", "scale" : "1x", "filename" : "icon_256x256.png" },
    { "idiom" : "mac", "size" : "256x256", "scale" : "2x", "filename" : "icon_256x256@2x.png" },
    { "idiom" : "mac", "size" : "512x512", "scale" : "1x", "filename" : "icon_512x512.png" },
    { "idiom" : "mac", "size" : "512x512", "scale" : "2x", "filename" : "icon_512x512@2x.png" }
  ],
  "info" : { "version" : 1, "author" : "xcode" }
}
EOF

done

echo "All iconsets generated in $GEN_DIR"
