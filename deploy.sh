#!/usr/bin/env sh
npm run build
# navigate into the build output directory
git add dist
git commit -m 'deploy'
git push -f origin gh-pages