#!/bin/sh

#set -euo pipefail
set -eu

exec tini -- pastebin --db=/root/pastebin.db
#exec tini pastebin 
