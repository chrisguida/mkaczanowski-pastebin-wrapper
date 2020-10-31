#!/bin/sh

#set -euo pipefail
set -eu

exec tini -- pastebin --db=/root/pastebin.db --address=0.0.0.0
#exec tini pastebin 
