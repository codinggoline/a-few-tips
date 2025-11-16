#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "'fzf' is required but not installed."
    echo "How to install: sudo apt-get install fzf"
    exit 1
fi

clear
echo "**************************************"
echo "** Welcome to Docker Cleaner Script **"
echo "**************************************"
echo ""

# Retrieve images
mapfile -t IMAGES < <(docker images --format "{{.Repository}}:{{.Tag}} {{.ID}}")

if [ ${#IMAGES[@]} -eq 0 ]; then

    echo "**************************************"
    echo "**       No images available.       **"
    echo "**************************************"
    exit 0
fi

# Build the list
LIST=""
for line in "${IMAGES[@]}"; do
    IFS=' ' read -r NAME ID <<< "$line"
    LIST+=" $ID  |  $NAME"$'\n'
done
LIST="${LIST%$'\n'}"

# FZF Menu (DARK mode by default)
SELECTED=$(echo -e "$LIST" | \
    fzf --multi --border --height=80% --reverse \
        --prompt="◯ Select images to delete: " \
        --header="Space = Select • Enter = Confirm • Ctrl+C = Cancel" \
        --bind 'space:toggle,tab:toggle' \
        --pointer="◯ " \
        --marker="◉")

if [ -z "$SELECTED" ]; then
    echo "**************************************"
    echo "**        No images selected.       **"
    echo "**************************************"
    exit 0
fi

# Processing
echo "$SELECTED" | while read -r LINE; do
    IMAGE_ID=$(echo "$LINE" | awk '{print $1}')
    IMAGE_NAME=$(echo "$LINE" | cut -d'|' -f2- | xargs)

    echo ""
    echo "######################################"
    echo "## Image : $IMAGE_NAME              ##"
    echo "## ID    : $IMAGE_ID                ##"
    echo "######################################"

    # Associated containers
    mapfile -t CONTAINERS < <(docker ps -a --filter "ancestor=$IMAGE_ID" --format "{{.ID}}")

    if [ ${#CONTAINERS[@]} -gt 0 ]; then
        echo "Associated containers:"
        for c in "${CONTAINERS[@]}"; do
            echo " - $c"
        done

        # Remove containers + volumes
        for c in "${CONTAINERS[@]}"; do
            docker rm -fv "$c"
            echo "**************************************"
            echo "**      Container $c removed.       **"
            echo "**************************************"
        done
    else
        echo "**************************************"
        echo "**    No associated containers.     **"
        echo "**************************************"
    fi

    # Remove image
    docker rmi -f "$IMAGE_ID"
    echo "Image $IMAGE_NAME removed."

    echo ""
done

echo ""
echo "**************************************"
echo "**        Cleaning completed        **"
echo "**************************************"
