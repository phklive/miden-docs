#!/bin/bash

# Set the URLs of the repositories
MIDDEN_CLIENT_REPO="https://github.com/0xPolygonMiden/miden-client.git"
MIDDEN_NODE_REPO="https://github.com/0xPolygonMiden/miden-node.git"
MIDDEN_BASE_REPO="https://github.com/0xPolygonMiden/miden-base.git"

# Define the local directories where the docs will be placed
CLIENT_DIR="miden/miden-client"
NODE_DIR="miden/miden-node"
BASE_DIR="miden/miden-base"

# Function to clone and copy docs from a repository
update_docs() {
    REPO_URL=$1
    DEST_DIR=$2
    TEMP_DIR=$(mktemp -d)
    
    # Clone the repository sparsely
    git clone --depth 1 --filter=blob:none --sparse "$REPO_URL" "$TEMP_DIR"
    
    # Navigate to the temporary directory
    cd "$TEMP_DIR"
    
    # Set sparse checkout to include only the docs directory
    git sparse-checkout set docs
    
    # Move back to the original directory
    cd - > /dev/null
    
    # Remove the existing local directory if it exists
    rm -rf "$DEST_DIR"
    
    # Create the destination directory if it doesn't exist
    mkdir -p "$DEST_DIR"
    
    # Copy the docs directory from the temporary clone to your repository
    cp -r "$TEMP_DIR/docs/"* "$DEST_DIR/"
    
    # Clean up the temporary directory
    rm -rf "$TEMP_DIR"
    
    echo "Updated documentation from $REPO_URL to $DEST_DIR"
}

# Update miden-client docs
update_docs "$MIDDEN_CLIENT_REPO" "$CLIENT_DIR"

# Update miden-node docs
update_docs "$MIDDEN_NODE_REPO" "$NODE_DIR"

# Update miden-base docs
update_docs "$MIDDEN_BASE_REPO" "$BASE_DIR"

echo "All documentation has been updated."