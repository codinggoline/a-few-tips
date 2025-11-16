#!/bin/bash

if ! command -v zenity &> /dev/null; then
    echo "Zenity is not installed."
    echo "sudo apt-get install zenity"
    exit 1
fi

IMAGES=$(docker images --format "{{.ID}}|{{.Repository}}:{{.Tag}}" \
    | awk -F"|" '{print $1 " " $2}')

if [ -z "$IMAGES" ]; then
    zenity --error --text="No images available."
    exit 0
fi

SELECT=$(zenity --list \
    --title="Welcome to Docker Image Cleaner" \
    --text="Select images to delete" \
    --width=400 --height=400 \
    --multiple --separator=" " \
    --checklist \
    --column="ID" --column="Image" \
    $IMAGES)

[ -z "$SELECT" ] && exit 0

for IMAGE_ID in $SELECT; do
    IMAGE_NAME=$(docker images --format "{{.ID}} {{.Repository}}:{{.Tag}}" | grep "^$IMAGE_ID" | awk '{print $2}')

    # Associated containers
    CONTAINERS=$(docker ps -a --filter "ancestor=$IMAGE_ID" --format "{{.ID}}")

    for c in $CONTAINERS; do
        docker rm -fv "$c"
    done

    docker rmi -f "$IMAGE_ID"
done

# Clean up dangling volumes
docker volume prune -f

# Clean up unused networks
docker network prune -f

zenity --info --text="Cleanup completed."
