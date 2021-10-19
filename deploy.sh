#!/usr/bin/env sh
cd dist
npm run build
# navigate into the build output directory
git add -A
git commit -m 'deploy'
git push -u origin gh-pages
cd -