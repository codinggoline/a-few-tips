# List docker's image
docker images -a
docker image ls
docker images

# Delete a specific image
docker rmi ImageName

# Remove all images
docker rmi $(docker images -a -q)

# List  containers
docker container ls
docker ps -a

# Remove container
docker rm ID_or_Name

# Remove all
docker stop $(docker ps -a -q) # Stop all
docker rm $(docker ps -a -q)

# ============================================================

