#!/bin/bash
# Function to update Dockerfile content and save as Dockerfile-new
update_dockerfile() {
    local dockerfile_path=$1
    local new_dockerfile_path="${dockerfile_path}-new"
    
    echo "Creating updated Dockerfile at $new_dockerfile_path"
    
    # Use sed to replace the aflnet clone URL and save to a new file
    sed 's|git clone https://github.com/profuzzbench/aflnet.git|git clone https://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@github.com/5angjun/aflnet-guided-older aflnet|' "$dockerfile_path" > "$new_dockerfile_path"
    
    echo "Updated Dockerfile saved as $new_dockerfile_path"
}

# Find all Dockerfiles in subdirectories and create updated versions
find . -type f -name 'Dockerfile' | while read -r dockerfile; do
    update_dockerfile "$dockerfile"
done

echo "All Dockerfiles updated successfully and saved as Dockerfile-new!"
