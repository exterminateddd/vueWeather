#!/usr/bin/env sh
npm run build
# navigate into the build output directory
cd dist
git add -A
git commit -m 'deploy'
git push -u origin gh-pages
cd -