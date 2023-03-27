#!/bin/bash

me="SSH2HUJI"
# Define variables
current_version=1.08
version_file=tmp
known_hosts=~/.ssh/known_hosts
look_for="bava.cs.huji.ac.il"

# Check version number
echo "[$me] Checking version number..."
curl --silent --output "$version_file" https://raw.githubusercontent.com/danielnachumdev/SSH2HUJI/main/version
count=0
while read -r x; do
  if [ $count -eq 0 ]; then
    if (( $(echo "$current_version < $x" |bc -l) )); then
      echo "[$me] LATEST VERSION=$x"
      echo "[$me] CURRENT_VERSION=$current_version"
      echo "[$me] go to https://github.com/danielnachumdev/SSH2HUJI to download the latest version"
      rm "$version_file"
    else
      echo "[$me] good to go!"
      rm "$version_file"
    fi
  fi
  count=$((count+1))
done < "$version_file"

# Setup known_hosts
if grep -q "$look_for" "$known_hosts"; then
  echo "known_hosts already contains path"
else
  echo "first time setup may take a few seconds..."
  ssh-keyscan -t rsa "$look_for" >> "$known_hosts"
fi

# Login
read -p "[$me] Enter CSE username: " user
ssh -CXJ "$user"@"$look_for" "$user"@river-01

# Exit
read -p "Press any key to exit..." -n 1 -r