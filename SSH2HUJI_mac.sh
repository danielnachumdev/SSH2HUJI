#!/bin/bash

me="SSH2HUJI"

# Update check
current_version="1.08"
version_file="tmp"
echo "[$me] Checking version number..."
curl --silent --output $version_file https://raw.githubusercontent.com/danielnachumdev/SSH2HUJI/main/version
count=0
while read x; do
    if [[ $count -eq 0 ]]; then # this is to check the version if this is a .sh file
        if [[ $current_version < $x ]]; then
            echo "[$me] LATEST VERSION=$x"
            echo "[$me] CURRENT_VERSION=$current_version"
            echo "[$me] Go to https://github.com/danielnachumdev/SSH2HUJI to download the latest version"
            rm $version_file
            exit 0
        else
            echo "[$me] Good to go!"
            rm $version_file
        fi
    fi
    count=$((count+1))
done < $version_file

known_hosts="$HOME/.ssh/known_hosts"
look_for="bava.cs.huji.ac.il"

# Does known_hosts already contain the path?
if grep -q "$look_for" $known_hosts; then
    # Do nothing, it already exists
    :
else
    echo "[$me] First time setup may take a few seconds..."
    ssh-keyscan -t rsa bava.cs.huji.ac.il >> $known_hosts
fi

read -p "[$me] Enter CSE username: " user
ssh -CXJ $user@bava.cs.huji.ac.il $user@river-01

exit 0