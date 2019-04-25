#!/usr/bin/env sh

set -e

if [ "$srcRepo" == " " ]; then
    # srcRepo not provided; git will fetch from configured origin fetch url
    srcRepo=$(git remote get-url origin)
fi

host=$(echo "$srcRepo" | awk -F/ '{print $3}')

echo "adding $host to .netrc"
echo -e "machine $host\n" \
"login ${username}\n"\
"password $password" > ~/.netrc

fetchCmd='git fetch'

# handle opts
if [ "$srcRepo" != " " ]; then
    fetchCmd=$(printf "%s %s" "$fetchCmd" "$srcRepo")
fi

if [ "$refSpec" != " " ]; then
    fetchCmd=$(printf "%s %s" "$fetchCmd" "$refSpec")
fi

eval "$fetchCmd"