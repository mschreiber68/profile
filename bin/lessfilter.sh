#!/bin/sh

# If pygmentize has no lexer for given file, use some custom heuristics
if pygmentize "$1" 2>&1 | grep 'no lexer' >/dev/null; then
  case "$1" in
      *.sh|*.bash|*.bash_*|*.zsh|*.zsh_*)
          pygmentize -f 256 -l sh "$1"
          ;;

      *)
          if grep -e '#!/bin/bash' -e '#!/bin/sh' -e '#!/bin/zsh' "$1" > /dev/null; then
              pygmentize -f 256 -l sh "$1"
          else
              exit 1
          fi
  esac
else
  pygmentize -f 256 "$1"
fi

exit 0
