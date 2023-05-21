#!/bin/bash

me="SSH2HUJI"
if ! which curl >/dev/null; then
  echo "[$me] curl is not installed. Please install it and try again."
  exit 1
fi

if ! which ssh >/dev/null; then
  echo "[$me] ssh is not installed. Please install it and try again."
  exit 1
fi

# Check version
current_version=1.11
version_file=tmp
echo "[$me] Checking version number..."
curl --silent --output "$version_file" https://raw.githubusercontent.com/danielnachumdev/SSH2HUJI/main/version
if [ $? -ne 0 ]; then
    echo "[$me] ERROR: Failed to download version file"
    exit 1
fi

while IFS= read -r line; do
    if [[ $line =~ ^[0-9]+\.[0-9]+$ ]]; then
        if (( $(echo "$current_version < $line" | bc -l) )); then
            echo "[$me] LATEST VERSION=$line"
            echo "[$me] CURRENT_VERSION=$current_version"
            echo "[$me] Go to https://github.com/danielnachumdev/SSH2HUJI to download the latest version"
        else
            echo "[$me] Good to go!"
        fi
    fi
done < "$version_file"
rm -f "$version_file"

known_hosts=~/.ssh/known_hosts
look_for="bava.cs.huji.ac.il"

# Check if known_hosts already contains path
if grep -q "$look_for" "$known_hosts"; then
    # Do nothing, it already exists
    :
else
    echo "[$me] First time setup may take a few seconds..."
    ssh-keyscan -t rsa bava.cs.huji.ac.il >> "$known_hosts"
fi

read -p "[$me] Enter CSE username: " user
ssh -CXJ "$user@bava.cs.huji.ac.il" "$user@river-01"

