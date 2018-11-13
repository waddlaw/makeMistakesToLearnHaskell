#!/bin/bash
set -e

stack build --flag makeMistakesToLearnHaskell:static
stack image container --no-build
docker run --rm -it -v $(pwd)/ans:/app/ans mmlh-entrypoint.sh bash