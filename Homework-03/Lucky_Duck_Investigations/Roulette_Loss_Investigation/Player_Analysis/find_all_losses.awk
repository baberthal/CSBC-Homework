#!/usr/bin/awk -f

/-\$[[:digit:],]+/ {
  print substr(FILENAME, 0, 4), $0
}
